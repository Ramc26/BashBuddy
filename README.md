# 🧬 BashBuddy — Sentient Terminal Companion

<p align="center">
  <img src="https://img.shields.io/badge/version-2.0-blue" alt="Version 2.0">
  <img src="https://img.shields.io/badge/python-3.8+-green" alt="Python 3.8+">
  <img src="https://img.shields.io/badge/shell-zsh%20%7C%20bash-orange" alt="Zsh | Bash">
  <img src="https://img.shields.io/badge/license-MIT-lightgrey" alt="MIT License">
</p>

**BashBuddy** is your personal terminal companion that **learns**, **evolves**, and **grows** alongside your workflow. It monitors your shell history and transforms into one of four sentient personas based on how you use your terminal — complete with evolving ASCII art, XP leveling, and streak bonuses.

## ✨ Features

### 🧬 Sentient Evolution Engine
- **Automatic mode detection** — BashBuddy analyzes your recent commands and identifies your current working mode
- **4 Unique Personas** with distinct ASCII art:

  | Mode | Trigger | Icon |
  |---|---|---|
  | **The Architect** | `git`, `merge`, `branch`, `rebase`, `commit`... | 🏛️ |
  | **The Explorer** | `ls`, `cd`, `cat`, `find`, `grep`, `tree`... | 🧭 |
  | **The Builder** | `python`, `pip`, `docker`, `npm`, `pytest`... | 🔨 |
  | **The Destroyer** | `sudo`, `rm`, `kill`, `chmod`, `pkill`... | 💀 |

- **XP & Leveling System** — Earn XP for every categorized command (+10 XP each)
- **5 Evolution Stages**: 🥚 Hatchling → 📘 Apprentice → ⚔️ Adept → 👑 Master → 🌟 Legendary
- **3 ASCII Art Tiers** per mode — your companion gets taller and more complex as you level up
- **Streak Bonuses** — Stay in the same mode for 3+ cycles to earn 1.5× XP!

### 🛠️ Shell Utilities
- **Navigation shortcuts** — `desk`, `down`, `docs`, `..`, `...`, etc.
- **Config helpers** — `bashrc`, `zshrc`, `reload`, `reloadz`
- **Git shortcuts** — `gs` (status), `gp` (push)
- **System tools** — `ports`, `myIP`, `weather`, `killPort`
- **Python environments** — `CreateVenv <version> <name>`

## 📦 Installation

### Prerequisites
- **macOS / Linux**
- **Python 3.8+** (for the evolution engine)
- **Zsh** or **Bash** shell

### Quick Install

```bash
# Clone the repository
git clone https://github.com/Ramc26/BashBuddy.git

# Navigate to the BashBuddy directory
cd BashBuddy

# Make the installer executable and run it
chmod +x install.sh
./install.sh
```

The installer will:
1. ✅ Check for Python 3 and required files
2. ✅ Copy `BashBuddy.sh` and `evolution_engine.py` to `/usr/local/bin/`
3. ✅ Create the initial companion state at `~/.bash_buddy_state.json`
4. ✅ Add a `source` line and evolution hook to your `~/.zshrc` (or `~/.bashrc`)
5. ✅ Run the first evolution

**Open a new terminal** to see your companion!

## 🎮 Commands

### Sentient Companion

| Command | Description |
|---|---|
| `bb-evolve` | Manually trigger the evolution engine to re-analyze your history and update your companion |
| `bb-status` | Display your current companion status (mode, level, XP, stage) |
| `bb-reset` | Reset your companion back to Level 1 Hatchling |

### Navigation

| Command | Description |
|---|---|
| `desk` | Go to Desktop |
| `down` | Go to Downloads |
| `docs` | Go to Documents |
| `pics` | Go to Pictures |
| `music` | Go to Music |
| `videos` | Go to Videos |
| `root` | Go to `/` |
| `home` | Go to `~` |
| `..` / `...` / `....` | Go up 1 / 2 / 3 directories |

### Configuration

| Command | Description |
|---|---|
| `bashrc` | Edit `~/.bashrc` |
| `zshrc` | Edit `~/.zshrc` |
| `reload` | Reload `.bashrc` |
| `reloadz` | Reload `.zshrc` |

### System & Network

| Command | Description |
|---|---|
| `ports` | Show all listening ports |
| `myIP` | Display your public IP |
| `weather [city]` | Show weather (defaults to current location) |
| `killPort <port>` | Kill process on a specific port |
| `showWifiPass` | Show saved Wi-Fi passwords |
| `updateSystem` | Update & upgrade system packages |

### Git

| Command | Description |
|---|---|
| `gs` | `git status` |
| `gp` | `git push` |

### Utilities

| Command | Description |
|---|---|
| `ll` | `ls -lh` — detailed file listing |
| `la` | `ls -lha` — all files including hidden |
| `cls` | Clear terminal |
| `bye` | Exit terminal |
| `CreateVenv <ver> <name>` | Create a Python virtual environment |

### Full Help

```bash
BashBuddy -help
```

## 🧪 Testing

### Test the Evolution Engine

```bash
# Navigate to BashBuddy directory
cd BashBuddy

# Run the engine directly (analyzes your real shell history)
python3 evolution_engine.py

# Check just the status without re-analyzing
python3 evolution_engine.py --status-only

# Analyze only the last 10 commands
python3 evolution_engine.py --analyze 10

# Run in quiet mode (how the background hook uses it)
python3 evolution_engine.py --quiet
```

### Inspect the State File

```bash
cat ~/.bash_buddy_state.json
```

You should see something like:
```json
{
  "mode": "The Explorer",
  "mode_icon": "🧭",
  "level": 2,
  "xp": 190,
  "evolution_stage": "Hatchling",
  "mode_scores": {
    "The Architect": 0,
    "The Explorer": 21,
    "The Builder": 19,
    "The Destroyer": 0
  }
}
```

### Test the Shell Display

```bash
# Source BashBuddy directly to see the companion status panel
source BashBuddy.sh

# Or after installing, just run:
bb-status

# Trigger a fresh evolution and see updated stats:
bb-evolve
```

### Test Different Modes

Run some commands to shift your mode and then evolve:

```bash
# Become "The Architect" 🏛️
git status && git log && git branch && git diff
bb-evolve

# Become "The Builder" 🔨
python3 --version && pip3 list && docker ps
bb-evolve

# Become "The Destroyer" 💀
# (careful with these!)
sudo whoami && kill -0 $$
bb-evolve
```

### Verify the Precmd Hook

After installation, the hook auto-triggers every 10 commands. Run ~10 commands and then check:

```bash
bb-status  # Should show updated XP and command count
```

## 🗑️ Uninstallation

```bash
# Remove scripts
sudo rm /usr/local/bin/BashBuddy.sh
sudo rm /usr/local/bin/bash_buddy_evolution.py

# Remove state file
rm ~/.bash_buddy_state.json

# Edit your shell config to remove BashBuddy lines
nano ~/.zshrc   # or ~/.bashrc
# Remove: source /usr/local/bin/BashBuddy.sh
# Remove: the __bb_precmd hook block

# Reload
source ~/.zshrc
```

## 📁 Project Structure

```
BashBuddy/
├── BashBuddy.sh          # Main shell script (aliases, functions, companion display)
├── evolution_engine.py    # Python evolution engine (history analysis, XP, leveling)
├── install.sh             # Installer script
├── README.md
└── LICENSE
```

## 🤝 Contributing

Contributions are welcome! Feel free to fork the project, create a new branch, and submit a pull request. Ideas for new modes, ASCII art, or features? Open an issue!

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 👤 Author

- **Ram Bikkina** — [Email](mailto:rambikkina@yahoo.com)
