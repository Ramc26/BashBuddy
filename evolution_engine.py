#!/usr/bin/env python3
"""
BashBuddy Evolution Engine — The Sentient Layer
================================================
Monitors shell history and evolves BashBuddy's personality, mode, and level
based on terminal activity patterns.

Usage:
    python3 evolution_engine.py [--history-file PATH] [--state-file PATH] [--analyze N]

No external dependencies — pure Python 3 stdlib.
"""

import json
import os
import re
import sys
import time
from collections import Counter
from datetime import datetime
from pathlib import Path

# ─── Configuration ───────────────────────────────────────────────────────────

DEFAULT_HISTORY_FILES = [
    os.path.expanduser("~/.zsh_history"),
    os.path.expanduser("~/.bash_history"),
]
DEFAULT_STATE_FILE = os.path.expanduser("~/.bash_buddy_state.json")
COMMANDS_TO_ANALYZE = 50
XP_PER_CATEGORIZED_CMD = 10
XP_PER_LEVEL = 100
MAX_LEVEL = 50

# ─── Mode Definitions ───────────────────────────────────────────────────────

MODES = {
    "The Architect": {
        "icon": "🏛️",
        "keywords": {
            "git": 3, "merge": 3, "branch": 3, "rebase": 3,
            "commit": 3, "push": 2, "pull": 2, "clone": 2,
            "stash": 2, "cherry-pick": 2, "diff": 1, "log": 1,
            "checkout": 2, "fetch": 2, "tag": 1,
        },
    },
    "The Explorer": {
        "icon": "🧭",
        "keywords": {
            "ls": 2, "cd": 2, "cat": 2, "find": 3, "grep": 3,
            "tree": 3, "head": 2, "tail": 2, "less": 2, "more": 1,
            "wc": 1, "file": 1, "locate": 2, "which": 1, "whereis": 1,
            "du": 2, "df": 1, "stat": 1, "pwd": 1,
        },
    },
    "The Builder": {
        "icon": "🔨",
        "keywords": {
            "python": 3, "python3": 3, "pip": 3, "pip3": 3,
            "docker": 3, "npm": 3, "yarn": 3, "cargo": 3,
            "make": 3, "cmake": 3, "pytest": 3, "gcc": 3,
            "node": 2, "go": 2, "rust": 2, "java": 2, "javac": 2,
            "mvn": 2, "gradle": 2, "webpack": 2, "vite": 2,
            "conda": 3, "jupyter": 2, "flask": 2, "uvicorn": 2,
            "gunicorn": 2, "poetry": 2, "pdm": 2,
        },
    },
    "The Destroyer": {
        "icon": "💀",
        "keywords": {
            "sudo": 2, "rm": 3, "kill": 3, "chmod": 2, "chown": 2,
            "pkill": 3, "killall": 3, "shutdown": 3, "reboot": 3,
            "rmdir": 2, "mkfs": 3, "fdisk": 3, "dd": 3,
            "iptables": 2, "systemctl": 1,
        },
    },
}

# ─── Evolution Stages ────────────────────────────────────────────────────────

EVOLUTION_STAGES = [
    (1, "Hatchling"),
    (5, "Apprentice"),
    (10, "Adept"),
    (20, "Master"),
    (35, "Legendary"),
]


def get_evolution_stage(level: int) -> str:
    """Return the evolution stage name for a given level."""
    stage = "Hatchling"
    for threshold, name in EVOLUTION_STAGES:
        if level >= threshold:
            stage = name
    return stage


# ─── History Parsing ─────────────────────────────────────────────────────────

def find_history_file(override: str | None = None) -> str | None:
    """Find the first available history file."""
    if override and os.path.isfile(override):
        return override
    for path in DEFAULT_HISTORY_FILES:
        if os.path.isfile(path):
            return path
    return None


def parse_zsh_history_line(line: str) -> str | None:
    """
    Parse a single line from zsh extended history format.
    Format: `: <timestamp>:0;<command>`
    Falls back to treating the entire line as a command.
    """
    # Zsh extended history format
    match = re.match(r"^:\s*\d+:\d+;(.+)$", line)
    if match:
        return match.group(1).strip()
    # Plain history line (bash-style or simple zsh)
    stripped = line.strip()
    if stripped and not stripped.startswith("#"):
        return stripped
    return None


def read_history(history_file: str, n: int = COMMANDS_TO_ANALYZE) -> list[str]:
    """Read the last N commands from the history file."""
    commands = []
    try:
        # Read file in binary to handle encoding issues gracefully
        with open(history_file, "rb") as f:
            raw_lines = f.readlines()

        # Process from the end for efficiency
        for raw_line in reversed(raw_lines):
            if len(commands) >= n:
                break
            try:
                line = raw_line.decode("utf-8", errors="replace").strip()
            except Exception:
                continue
            cmd = parse_zsh_history_line(line)
            if cmd:
                commands.append(cmd)

    except (OSError, IOError) as e:
        print(f"⚠️  Could not read history file: {e}", file=sys.stderr)
        return []

    # Reverse so oldest is first, newest is last
    commands.reverse()
    return commands


# ─── Mode Categorization ────────────────────────────────────────────────────

def extract_base_command(cmd: str) -> str:
    """Extract the base command from a full command string."""
    # Strip leading environment vars (e.g., `FOO=bar command`)
    parts = cmd.split()
    for part in parts:
        if "=" not in part or part.startswith("-"):
            return part.split("/")[-1]  # handle full paths like /usr/bin/git
    return parts[0] if parts else ""


def score_commands(commands: list[str]) -> dict[str, int]:
    """Score each mode based on the commands list."""
    scores: dict[str, int] = {mode: 0 for mode in MODES}

    for cmd_str in commands:
        base_cmd = extract_base_command(cmd_str).lower()

        for mode_name, mode_data in MODES.items():
            for keyword, weight in mode_data["keywords"].items():
                if base_cmd == keyword:
                    scores[mode_name] += weight
                    break  # A command matches at most one keyword per mode
                # Also check if command starts with the keyword (e.g., "git commit")
                if cmd_str.lower().startswith(keyword + " "):
                    scores[mode_name] += weight
                    break

    return scores


def determine_mode(commands: list[str]) -> tuple[str, str, dict[str, int]]:
    """
    Determine the current mode based on recent commands.
    Returns (mode_name, mode_icon, scores_dict).
    """
    scores = score_commands(commands)

    if not any(scores.values()):
        # No matching commands — default to Explorer
        return "The Explorer", MODES["The Explorer"]["icon"], scores

    # Find the max score; break ties with most recent command
    max_score = max(scores.values())
    top_modes = [m for m, s in scores.items() if s == max_score]

    if len(top_modes) == 1:
        winner = top_modes[0]
    else:
        # Tie-breaker: check the most recent commands
        winner = top_modes[0]
        for cmd_str in reversed(commands):
            base_cmd = extract_base_command(cmd_str).lower()
            for mode_name in top_modes:
                if base_cmd in MODES[mode_name]["keywords"]:
                    winner = mode_name
                    break
                if any(cmd_str.lower().startswith(kw + " ") for kw in MODES[mode_name]["keywords"]):
                    winner = mode_name
                    break
            else:
                continue
            break

    return winner, MODES[winner]["icon"], scores


# ─── State Management ───────────────────────────────────────────────────────

def load_state(state_file: str) -> dict:
    """Load the current evolution state from JSON, or return defaults."""
    defaults = {
        "mode": "The Explorer",
        "mode_icon": "🧭",
        "level": 1,
        "xp": 0,
        "xp_to_next_level": XP_PER_LEVEL,
        "total_commands_analyzed": 0,
        "mode_scores": {m: 0 for m in MODES},
        "last_updated": datetime.now().isoformat(timespec="seconds"),
        "evolution_stage": "Hatchling",
        "streak_count": 0,
        "previous_mode": None,
    }
    try:
        with open(state_file, "r") as f:
            state = json.load(f)
        # Ensure all keys exist
        for key, val in defaults.items():
            state.setdefault(key, val)
        return state
    except (FileNotFoundError, json.JSONDecodeError):
        return defaults


def save_state(state: dict, state_file: str) -> None:
    """Save the evolution state to JSON."""
    try:
        with open(state_file, "w") as f:
            json.dump(state, f, indent=2)
    except OSError as e:
        print(f"⚠️  Could not save state: {e}", file=sys.stderr)


def calculate_xp_gain(commands: list[str]) -> int:
    """Calculate XP gained from the analyzed commands."""
    categorized = 0
    for cmd_str in commands:
        base_cmd = extract_base_command(cmd_str).lower()
        for mode_data in MODES.values():
            if base_cmd in mode_data["keywords"]:
                categorized += 1
                break
            if any(cmd_str.lower().startswith(kw + " ") for kw in mode_data["keywords"]):
                categorized += 1
                break
    return categorized * XP_PER_CATEGORIZED_CMD


# ─── Main Evolution Logic ───────────────────────────────────────────────────

def evolve(
    history_file: str | None = None,
    state_file: str = DEFAULT_STATE_FILE,
    num_commands: int = COMMANDS_TO_ANALYZE,
) -> dict:
    """
    Run the evolution engine:
    1. Read recent commands
    2. Determine mode
    3. Calculate XP & level
    4. Save state
    """
    # Find history
    hist_path = find_history_file(history_file)
    if not hist_path:
        print("⚠️  No history file found. Skipping evolution.", file=sys.stderr)
        return load_state(state_file)

    # Read commands
    commands = read_history(hist_path, num_commands)
    if not commands:
        return load_state(state_file)

    # Load existing state
    state = load_state(state_file)

    # Determine mode
    mode, icon, scores = determine_mode(commands)

    # Track mode streaks
    if state["mode"] == mode:
        state["streak_count"] = state.get("streak_count", 0) + 1
    else:
        state["previous_mode"] = state["mode"]
        state["streak_count"] = 1

    # Calculate XP
    xp_gain = calculate_xp_gain(commands)

    # Streak bonus: +50% XP if mode is consistent
    if state["streak_count"] >= 3:
        xp_gain = int(xp_gain * 1.5)

    state["xp"] += xp_gain
    state["total_commands_analyzed"] += len(commands)

    # Level up
    new_level = min(state["xp"] // XP_PER_LEVEL + 1, MAX_LEVEL)
    state["level"] = new_level
    state["xp_to_next_level"] = XP_PER_LEVEL - (state["xp"] % XP_PER_LEVEL)

    # Update mode & metadata
    state["mode"] = mode
    state["mode_icon"] = icon
    state["mode_scores"] = scores
    state["evolution_stage"] = get_evolution_stage(new_level)
    state["last_updated"] = datetime.now().isoformat(timespec="seconds")

    # Save
    save_state(state, state_file)

    return state


# ─── CLI Interface ───────────────────────────────────────────────────────────

def print_status(state: dict) -> None:
    """Print a brief status summary to stdout."""
    bar_len = 20
    filled = int((state["xp"] % XP_PER_LEVEL) / XP_PER_LEVEL * bar_len)
    bar = "█" * filled + "░" * (bar_len - filled)

    print(f"\n  {state['mode_icon']}  {state['mode']}  •  Level {state['level']} ({state['evolution_stage']})")
    print(f"  [{bar}] {state['xp'] % XP_PER_LEVEL}/{XP_PER_LEVEL} XP")
    print(f"  📊 Commands analyzed: {state['total_commands_analyzed']}")
    if state.get("streak_count", 0) >= 3:
        print(f"  🔥 Mode streak: {state['streak_count']} (1.5× XP bonus!)")
    print()


def main():
    import argparse

    parser = argparse.ArgumentParser(
        description="BashBuddy Evolution Engine — Sentient Terminal Companion",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--history-file", "-f",
        help="Path to shell history file (auto-detected if omitted)",
    )
    parser.add_argument(
        "--state-file", "-s",
        default=DEFAULT_STATE_FILE,
        help=f"Path to state JSON file (default: {DEFAULT_STATE_FILE})",
    )
    parser.add_argument(
        "--analyze", "-n",
        type=int, default=COMMANDS_TO_ANALYZE,
        help=f"Number of recent commands to analyze (default: {COMMANDS_TO_ANALYZE})",
    )
    parser.add_argument(
        "--quiet", "-q",
        action="store_true",
        help="Suppress status output (for background/hook usage)",
    )
    parser.add_argument(
        "--status-only",
        action="store_true",
        help="Show current status without re-analyzing history",
    )

    args = parser.parse_args()

    if args.status_only:
        state = load_state(args.state_file)
        print_status(state)
        return

    state = evolve(
        history_file=args.history_file,
        state_file=args.state_file,
        num_commands=args.analyze,
    )

    if not args.quiet:
        print_status(state)


if __name__ == "__main__":
    main()
