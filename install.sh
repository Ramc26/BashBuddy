#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
#  BashBuddy Installer — Sentient Terminal Companion
# ═══════════════════════════════════════════════════════════════════════════════
# Author: Ram Bikkina
# Email: rambikkina@yahoo.com
# Version: 2.0
# Description: Installs BashBuddy + the Evolution Engine and sets up the
#              sentient precmd hook for automatic companion evolution.

set -e

bold=$(tput bold)
normal=$(tput sgr0)
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
cyan='\033[0;36m'
nc='\033[0m'

BASHBUDDY_SCRIPT="BashBuddy.sh"
EVOLUTION_ENGINE="evolution_engine.py"
INSTALL_PATH="/usr/local/bin/BashBuddy.sh"
ENGINE_INSTALL_PATH="/usr/local/bin/bash_buddy_evolution.py"
STATE_FILE="$HOME/.bash_buddy_state.json"

echo -e "${cyan}${bold}"
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   BashBuddy Sentient Companion Installer ║"
echo "  ╚══════════════════════════════════════════╝"
echo -e "${normal}${nc}"

# ─── Preflight Checks ───────────────────────────────────────────────────────

echo -e "${bold}[1/5]${normal} Running preflight checks..."

# Check BashBuddy script exists
if [ ! -f "$BASHBUDDY_SCRIPT" ]; then
    echo -e "${red}✗ Error: $BASHBUDDY_SCRIPT not found in the current directory.${nc}"
    exit 1
fi
echo -e "  ${green}✓${nc} Found $BASHBUDDY_SCRIPT"

# Check Evolution Engine exists
if [ ! -f "$EVOLUTION_ENGINE" ]; then
    echo -e "${red}✗ Error: $EVOLUTION_ENGINE not found in the current directory.${nc}"
    exit 1
fi
echo -e "  ${green}✓${nc} Found $EVOLUTION_ENGINE"

# Check Python 3
if command -v python3 &>/dev/null; then
    PY_VERSION=$(python3 --version 2>&1)
    echo -e "  ${green}✓${nc} $PY_VERSION detected"
else
    echo -e "${yellow}⚠️  Python 3 not found!${nc}"
    echo -e "  The evolution engine requires Python 3.8+."
    echo -e "  Install it via: ${bold}brew install python3${normal} (macOS)"
    echo -e "  BashBuddy core aliases will still work, but the sentient layer won't."
    echo -n "  Continue anyway? (y/N) "
    read -r confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# ─── Install Scripts ────────────────────────────────────────────────────────

echo -e "\n${bold}[2/5]${normal} Installing scripts..."

sudo cp "$BASHBUDDY_SCRIPT" "$INSTALL_PATH"
echo -e "  ${green}✓${nc} Copied BashBuddy.sh → $INSTALL_PATH"

sudo cp "$EVOLUTION_ENGINE" "$ENGINE_INSTALL_PATH"
sudo chmod +x "$ENGINE_INSTALL_PATH"
echo -e "  ${green}✓${nc} Copied evolution_engine.py → $ENGINE_INSTALL_PATH"

# ─── Initialize State ───────────────────────────────────────────────────────

echo -e "\n${bold}[3/5]${normal} Initializing companion state..."

if [ ! -f "$STATE_FILE" ]; then
    cat > "$STATE_FILE" << 'JSONEOF'
{
  "mode": "The Explorer",
  "mode_icon": "🧭",
  "level": 1,
  "xp": 0,
  "xp_to_next_level": 100,
  "total_commands_analyzed": 0,
  "mode_scores": {"The Architect": 0, "The Explorer": 0, "The Builder": 0, "The Destroyer": 0},
  "last_updated": null,
  "evolution_stage": "Hatchling",
  "streak_count": 0,
  "previous_mode": null
}
JSONEOF
    echo -e "  ${green}✓${nc} Created fresh state at $STATE_FILE"
else
    echo -e "  ${green}✓${nc} Existing state found at $STATE_FILE (preserved)"
fi

# ─── Shell Configuration ────────────────────────────────────────────────────

echo -e "\n${bold}[4/5]${normal} Configuring shell integration..."

# Determine which shell config to use
SHELL_CONFIG=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [ -n "$SHELL_CONFIG" ]; then
    SHELL_NAME=$(basename "$SHELL_CONFIG")

    # Add source line for BashBuddy
    if ! grep -q "source $INSTALL_PATH" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# BashBuddy — Sentient Terminal Companion" >> "$SHELL_CONFIG"
        echo "source $INSTALL_PATH" >> "$SHELL_CONFIG"
        echo -e "  ${green}✓${nc} Added BashBuddy source to ~/$SHELL_NAME"
    else
        echo -e "  ${green}✓${nc} BashBuddy source already in ~/$SHELL_NAME"
    fi

    # Add precmd hook (Zsh) or PROMPT_COMMAND (Bash) for evolution
    if [[ "$SHELL_CONFIG" == *".zshrc"* ]]; then
        if ! grep -q "__bb_precmd" "$SHELL_CONFIG"; then
            cat >> "$SHELL_CONFIG" << 'HOOKEOF'

# BashBuddy Evolution Hook — evolves your companion every 10 commands
__bb_cmd_count=0
__bb_precmd() {
    (( __bb_cmd_count++ ))
    if (( __bb_cmd_count % 10 == 0 )); then
        python3 /usr/local/bin/bash_buddy_evolution.py --quiet &>/dev/null &
        disown 2>/dev/null
    fi
}
precmd_functions+=(__bb_precmd)
HOOKEOF
            echo -e "  ${green}✓${nc} Added evolution precmd hook to ~/.zshrc"
        else
            echo -e "  ${green}✓${nc} Evolution hook already in ~/.zshrc"
        fi
    elif [[ "$SHELL_CONFIG" == *".bashrc"* ]]; then
        if ! grep -q "__bb_prompt_cmd" "$SHELL_CONFIG"; then
            cat >> "$SHELL_CONFIG" << 'HOOKEOF'

# BashBuddy Evolution Hook — evolves your companion every 10 commands
__bb_cmd_count=0
__bb_prompt_cmd() {
    (( __bb_cmd_count++ ))
    if (( __bb_cmd_count % 10 == 0 )); then
        python3 /usr/local/bin/bash_buddy_evolution.py --quiet &>/dev/null &
        disown 2>/dev/null
    fi
}
PROMPT_COMMAND="__bb_prompt_cmd; ${PROMPT_COMMAND}"
HOOKEOF
            echo -e "  ${green}✓${nc} Added evolution PROMPT_COMMAND hook to ~/.bashrc"
        else
            echo -e "  ${green}✓${nc} Evolution hook already in ~/.bashrc"
        fi
    fi
else
    echo -e "${yellow}⚠️  No .zshrc or .bashrc found. Please manually source BashBuddy.sh in your shell config.${nc}"
fi

# ─── First Evolution ────────────────────────────────────────────────────────

echo -e "\n${bold}[5/5]${normal} Running first evolution..."

if command -v python3 &>/dev/null; then
    python3 "$ENGINE_INSTALL_PATH" --quiet 2>/dev/null || true
    echo -e "  ${green}✓${nc} Initial evolution complete"
else
    echo -e "  ${yellow}⚠️${nc} Skipped (Python 3 not available)"
fi

# ─── Done ────────────────────────────────────────────────────────────────────

echo ""
echo -e "${green}${bold}  ╔══════════════════════════════════════════════╗"
echo -e "  ║  🎉 BashBuddy Sentient Companion Installed! 🎉 ║"
echo -e "  ╚══════════════════════════════════════════════╝${normal}${nc}"
echo ""
echo -e "  ${bold}Your companion starts as a Level 1 Hatchling 🥚${normal}"
echo -e "  Use your terminal naturally and watch it evolve!"
echo ""
echo -e "  ${bold}Quick commands:${normal}"
echo -e "    ${cyan}bb-evolve${nc}    — Manually trigger evolution"
echo -e "    ${cyan}bb-status${nc}    — Check companion status"
echo -e "    ${cyan}bb-reset${nc}     — Reset to Level 1"
echo -e "    ${cyan}BashBuddy -help${nc} — See all commands"
echo ""
echo -e "  ${bold}Open a new terminal to see your companion! 🚀${normal}"
echo ""
