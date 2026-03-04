# 🧬 BashBuddy — Your Terminal Has Feelings Now

<p align="center">
  <img src="https://img.shields.io/badge/version-2.0-blue" alt="Version 2.0">
  <img src="https://img.shields.io/badge/python-3.8+-green" alt="Python 3.8+">
  <img src="https://img.shields.io/badge/shell-zsh%20%7C%20bash-orange" alt="Zsh | Bash">
  <img src="https://img.shields.io/badge/license-MIT-lightgrey" alt="MIT License">
</p>

BashBuddy isn't just another dotfile script. It's a **sentient terminal companion** that watches how you work, figures out what kind of dev you are, and evolves over time. Yes, your terminal now has a pet. You're welcome.

The more you use your terminal, the more it grows — from a Level 1 Hatchling 🥚 all the way to a Level 50 Legendary being. It even gets fancier ASCII art as it levels up.

## 🤔 What Does It Actually Do?

1. **Watches your shell history** — every 10 commands, a background Python script peeks at what you've been up to
2. **Picks your vibe** — based on your commands, it decides you're one of four personas:

   | Mode | You're Probably... | Trigger Commands |
   |---|---|---|
   | 🏛️ **The Architect** | Branching, merging, rebasing like a pro | `git`, `merge`, `branch`, `commit`... |
   | 🧭 **The Explorer** | Poking around the filesystem | `ls`, `cd`, `cat`, `find`, `grep`... |
   | 🔨 **The Builder** | Building stuff, running tests | `python`, `docker`, `npm`, `pytest`... |
   | 💀 **The Destroyer** | Living dangerously | `sudo`, `rm`, `kill`, `chmod`... |

3. **Levels you up** — earn XP for every command, get streak bonuses for staying in the same mode
4. **Shows off** — animated ASCII companion on startup, live stats on every prompt line

## ⚡ The Animations

This isn't your grandma's `.bashrc`. BashBuddy comes with:

- **Animated startup** — logo fades in line-by-line, scanning spinners ⠋⠙⠹⠸⠼⠴, companion panel reveals with delays
- **Live RPROMPT** — right side of every prompt shows mode, level, pulsing XP bar, and spinning indicator that updates in real-time
- **Evolve spinner** — fancy braille animation when you trigger an evolution

## 📦 Installation

You need:
- **macOS or Linux**
- **Python 3.8+** (for the brain)
- **Zsh** or **Bash**

```bash
git clone https://github.com/Ramc26/BashBuddy.git
cd BashBuddy
chmod +x install.sh
./install.sh
```

That's it. The installer handles everything:
- ✅ Copies scripts to `/usr/local/bin/`
- ✅ Creates your companion's state file
- ✅ Hooks into your shell config
- ✅ Runs the first evolution

**Open a new terminal** and say hello to your new buddy.

## 🗑️ Uninstallation

Changed your mind? No hard feelings (okay, maybe a little).

```bash
cd BashBuddy
chmod +x uninstall.sh
./uninstall.sh
```

It'll show your companion's final stats as a farewell, clean everything up, and back up your shell config. Just in case you miss us.

## 🎮 Commands

### Your Companion

| Command | What It Does |
|---|---|
| `bb-evolve` | Manually trigger evolution (with a cool spinner) |
| `bb-status` | Check your companion's current stats |
| `bb-reset` | Wipe everything and start over as a Hatchling |
| `buddy --help` | Show all available commands |

### Navigation Shortcuts

| Command | Goes To |
|---|---|
| `desk` | ~/Desktop |
| `down` | ~/Downloads |
| `docs` | ~/Documents |
| `pics` | ~/Pictures |
| `music` | ~/Music |
| `videos` | ~/Videos |
| `home` / `root` | ~ / / |
| `..` `...` `....` | Up 1, 2, or 3 directories |

### Quick Tools

| Command | Does |
|---|---|
| `ll` / `la` | Detailed / all file listing |
| `gs` / `gp` | git status / git push |
| `myIP` | Shows your public IP |
| `weather [city]` | Weather report (try `weather tokyo`) |
| `killPort 8080` | Kills whatever's hogging that port |
| `ports` | Shows all listening ports |
| `cls` / `bye` | Clear screen / exit terminal |
| `CreateVenv 3.11 myenv` | Create a Python virtual environment |
| `bashrc` / `zshrc` | Edit your shell config |
| `reload` / `reloadz` | Reload your shell config |

## 📊 How Leveling Works

- **+10 XP** per recognized command (out of the last 50 analyzed)
- **100 XP** = 1 level up
- **Streak bonus** — stay in the same mode for 3+ cycles = **1.5× XP**
- **Max level** — 50 (good luck getting there)

### Evolution Stages

| Level | Stage | How It Feels |
|---|---|---|
| 1–4 | 🥚 Hatchling | Fresh out of `source ~/.zshrc` |
| 5–9 | 📘 Apprentice | Getting the hang of things |
| 10–19 | ⚔️ Adept | You know your way around |
| 20–34 | 👑 Master | Terminal wizard status |
| 35–50 | 🌟 Legendary | You ARE the terminal |

Each mode also has **3 tiers of ASCII art** — the companion gets bigger and more detailed as you level up. A Level 1 Architect is a tiny house. A Level 35 Architect is a full cathedral.

## 🧪 Testing It Out

```bash
# Run the evolution engine directly
python3 evolution_engine.py

# Check the state file
cat ~/.bash_buddy_state.json

# See your stats
bb-status

# Force an evolution
bb-evolve

# Try shifting modes — do a bunch of git stuff:
git status && git log --oneline -5 && git branch
bb-evolve  # Should shift toward Architect 🏛️
```

## 📁 What's In The Box

```
BashBuddy/
├── BashBuddy.sh          # The main shell script (aliases, companion display, animations)
├── evolution_engine.py    # The brain (history analysis, XP, leveling)
├── install.sh             # One-command installer
├── uninstall.sh           # Clean uninstaller (with a goodbye message)
├── README.md              # You are here
└── LICENSE                # MIT — do whatever you want with it
```

## 🤝 Contributing

Got ideas? Found a bug? Want to add a new mode? (The Hacker? The DevOps? The Coffee Drinker?)

Fork it, branch it, PR it. All contributions welcome.

## 📄 License

MIT — free to use, modify, and share. Go wild.

## 👤 Author

**Ram Bikkina** — [rambikkina@yahoo.com](mailto:rambikkina@yahoo.com)

Built with ☕ and an unreasonable attachment to terminals.
