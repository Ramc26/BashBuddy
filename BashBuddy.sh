#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
dim=$(tput dim 2>/dev/null || echo "")
cyan='\033[0;36m'
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
magenta='\033[0;35m'
white='\033[0;37m'
nc='\033[0m' # No Color

# ═══════════════════════════════════════════════════════════════════════════════
#  BashBuddy — Sentient Terminal Companion
# ═══════════════════════════════════════════════════════════════════════════════

# ─── ASCII Logo ──────────────────────────────────────────────────────────────

echo """

░▒▓███████▓▒░ ░▒▓██████▓▒░ ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░░▒▓████████▓▒░░▒▓██████▓▒░░▒▓████████▓▒░      ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░     
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░     
░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░   ░▒▓█▓▒░     
                                                                                                                              
"""

# ─── Companion Status ────────────────────────────────────────────────────────

__bb_state_file="$HOME/.bash_buddy_state.json"

# Read a JSON key from the state file (lightweight, no jq needed)
__bb_read_json() {
    local key="$1"
    if [ -f "$__bb_state_file" ]; then
        python3 -c "
import json, sys
try:
    with open('$__bb_state_file') as f:
        d = json.load(f)
    print(d.get('$key', ''))
except:
    print('')
" 2>/dev/null
    fi
}

# Get ASCII companion based on mode and level tier
__bb_get_companion() {
    local mode="$1"
    local level="$2"
    local tier=1

    # Determine tier: 1 (levels 1-9), 2 (levels 10-24), 3 (levels 25+)
    if [ "$level" -ge 25 ] 2>/dev/null; then
        tier=3
    elif [ "$level" -ge 10 ] 2>/dev/null; then
        tier=2
    fi

    case "$mode" in
        "The Architect")
            if [ $tier -eq 1 ]; then
                echo -e "${cyan}"
                echo "       ╔═╗       "
                echo "       ║█║       "
                echo "      ╔╩═╩╗      "
                echo "      ╚═══╝      "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${cyan}"
                echo "      ╔═══╗      "
                echo "     ╔╣ █ ╠╗     "
                echo "     ║╚═══╝║     "
                echo "    ╔╩═════╩╗    "
                echo "    ║ ║   ║ ║    "
                echo "    ╚═╩═══╩═╝    "
                echo -e "${nc}"
            else
                echo -e "${cyan}"
                echo "        ▲        "
                echo "       ╱█╲       "
                echo "      ╔╩═╩╗      "
                echo "     ╔╣ ◆ ╠╗     "
                echo "    ╔╩╩═══╩╩╗    "
                echo "    ║ ║ ◆ ║ ║    "
                echo "   ╔╩═╩═══╩═╩╗   "
                echo "   ║ ║ ║ ║ ║ ║   "
                echo "   ╚═╩═╩═╩═╩═╝   "
                echo -e "${nc}"
            fi
            ;;
        "The Explorer")
            if [ $tier -eq 1 ]; then
                echo -e "${green}"
                echo "       ◯        "
                echo "      /|\\       "
                echo "      / \\       "
                echo "     🧭         "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${green}"
                echo "     ░░◯░░      "
                echo "    ░/███\\░     "
                echo "     / ║ \\      "
                echo "    /  ║  \\     "
                echo "   🧭 ═══ 🗺️    "
                echo -e "${nc}"
            else
                echo -e "${green}"
                echo "    .*★☆★*.     "
                echo "     ░░◯░░      "
                echo "   ░░/███\\░░   "
                echo "  ░░/ ║█║ \\░░  "
                echo "    / ║║║ \\     "
                echo "   /  ║║║  \\    "
                echo "  🧭 ══╬══ 🗺️   "
                echo "      ║║║       "
                echo "   ⚓═╩╩╩═🔭   "
                echo -e "${nc}"
            fi
            ;;
        "The Builder")
            if [ $tier -eq 1 ]; then
                echo -e "${yellow}"
                echo "      ╔══╗      "
                echo "     ═╣██╠═     "
                echo "      ╚══╝      "
                echo "      🔨        "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${yellow}"
                echo "     ╔════╗     "
                echo "    ═╣ ⚙️ ╠═    "
                echo "     ╠════╣     "
                echo "    ═╣ 🔧 ╠═    "
                echo "     ╚════╝     "
                echo "      🔨🔨      "
                echo -e "${nc}"
            else
                echo -e "${yellow}"
                echo "   ╔══════════╗  "
                echo "   ║ ⚙️  ⚙️  ⚙️ ║  "
                echo "   ╠══════════╣  "
                echo "   ║ 🔧 ██ 🔧 ║  "
                echo "   ╠══════════╣  "
                echo "   ║ ⚙️  ⚙️  ⚙️ ║  "
                echo "   ╚══════════╝  "
                echo "    🔨🔨🔨🔨    "
                echo "   ════════════  "
                echo -e "${nc}"
            fi
            ;;
        "The Destroyer")
            if [ $tier -eq 1 ]; then
                echo -e "${red}"
                echo "      ╱▔╲       "
                echo "     ( ◉ )      "
                echo "      ╲▁╱       "
                echo "      💀        "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${red}"
                echo "    ╱▔▔▔▔▔╲     "
                echo "   ( ◉   ◉ )    "
                echo "   (  ▽▽▽  )    "
                echo "    ╲▁▁▁▁▁╱     "
                echo "   🔥 💀 🔥    "
                echo -e "${nc}"
            else
                echo -e "${red}"
                echo "  🔥🔥🔥🔥🔥🔥  "
                echo "    ╱▔▔▔▔▔▔▔╲   "
                echo "   ( ◉     ◉ )  "
                echo "   (  ▽▽▽▽▽  )  "
                echo "    ╲▁▁▁▁▁▁▁╱   "
                echo "     ╱║███║╲     "
                echo "    ╱ ║███║ ╲    "
                echo "   🔥💀⚡💀🔥  "
                echo "  🔥🔥🔥🔥🔥🔥  "
                echo -e "${nc}"
            fi
            ;;
        *)
            echo "      🤖        "
            ;;
    esac
}

# Display companion status (full panel — used on shell startup)
__bb_show_companion_status() {
    if [ ! -f "$__bb_state_file" ]; then
        echo -e "  ${dim}🥚 No evolution data yet. Run ${bold}bb-evolve${normal}${dim} to awaken your companion!${normal}"
        echo ""
        return
    fi

    local mode=$(__bb_read_json "mode")
    local mode_icon=$(__bb_read_json "mode_icon")
    local level=$(__bb_read_json "level")
    local xp=$(__bb_read_json "xp")
    local stage=$(__bb_read_json "evolution_stage")
    local total=$(__bb_read_json "total_commands_analyzed")
    local streak=$(__bb_read_json "streak_count")

    # Fallbacks
    [ -z "$mode" ] && mode="Unknown"
    [ -z "$mode_icon" ] && mode_icon="🤖"
    [ -z "$level" ] && level=1
    [ -z "$xp" ] && xp=0
    [ -z "$stage" ] && stage="Hatchling"
    [ -z "$total" ] && total=0
    [ -z "$streak" ] && streak=0

    # Calculate XP bar
    local xp_in_level=$((xp % 100))
    local bar_len=20
    local filled=$((xp_in_level * bar_len / 100))
    local empty=$((bar_len - filled))
    local bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done

    # Mode color
    local mode_color="$white"
    case "$mode" in
        "The Architect") mode_color="$cyan" ;;
        "The Explorer") mode_color="$green" ;;
        "The Builder") mode_color="$yellow" ;;
        "The Destroyer") mode_color="$red" ;;
    esac

    echo -e "  ┌────────────────────────────────────────┐"
    echo -e "  │  ${bold}⚡ COMPANION STATUS ⚡${normal}                  │"
    echo -e "  ├────────────────────────────────────────┤"

    # Show ASCII companion
    __bb_get_companion "$mode" "$level"

    echo -e "  │  ${mode_color}${bold}$mode_icon  $mode${normal}                        "
    echo -e "  │  ⭐ Level ${bold}$level${normal} — ${magenta}$stage${normal}              "
    echo -e "  │  [${green}${bar}${nc}] ${xp_in_level}/100 XP           "
    echo -e "  │  📊 Commands: ${bold}$total${normal}                    "

    if [ "$streak" -ge 3 ] 2>/dev/null; then
        echo -e "  │  🔥 Streak: ${bold}${streak}${normal} (1.5× XP!)              "
    fi

    echo -e "  └────────────────────────────────────────┘"
    echo ""
}

# Show companion status on shell load
__bb_show_companion_status

# ─── RPROMPT: Real-Time Companion Status (right side of every prompt) ────────

# Build a compact RPROMPT string from the state file
__bb_build_rprompt() {
    if [ ! -f "$__bb_state_file" ]; then
        echo "🥚 bb-evolve"
        return
    fi

    # Read state in a single python call for speed
    local rprompt_data
    rprompt_data=$(python3 -c "
import json
try:
    with open('$__bb_state_file') as f:
        d = json.load(f)
    mode_icon = d.get('mode_icon', '🤖')
    level = d.get('level', 1)
    xp = d.get('xp', 0)
    stage = d.get('evolution_stage', '?')
    xp_in = xp % 100
    bar_len = 10
    filled = int(xp_in / 100 * bar_len)
    bar = '█' * filled + '░' * (bar_len - filled)
    streak = d.get('streak_count', 0)
    streak_str = ' 🔥' if streak >= 3 else ''
    print(f'{mode_icon} L{level} {stage} [{bar}] {xp_in}/100{streak_str}')
except:
    print('🤖 ?')
" 2>/dev/null)

    echo "$rprompt_data"
}

# Update RPROMPT before every prompt render
__bb_update_rprompt() {
    RPROMPT=$(__bb_build_rprompt)
}

# Register the RPROMPT updater in precmd (Zsh)
if [[ -n "$ZSH_VERSION" ]]; then
    # Add to precmd_functions if not already there
    if [[ ! " ${precmd_functions[*]} " =~ " __bb_update_rprompt " ]]; then
        precmd_functions+=(__bb_update_rprompt)
    fi
fi

# Welcome Message
echo -e "✨ \e[1mHey there, coding superstar! You've just leveled up with Bash Buddy! ✨\e[0m"
echo -e "\e[1mYour personal terminal sidekick is now installed and ready to work its magic. 🚀\e[0m"
echo -e "\e[1mRun 'buddy --help' to explore all the cool tricks and turbocharge your productivity! 💻🔥\e[0m"
echo -e "\e[1mMay your coding be bug-free and your terminal always obedient! 😄🤖\e[0m"
echo """
${bold}Author: ${normal}RamBikkina ${bold}<<<--->>> ${bold}Email: ${normal}rambikkina@yahoo.com ${bold}<<<--->>> ${bold}Version: ${normal}2.0
${bold}Description: ${normal}Bash Buddy is your sentient terminal companion — it learns, evolves, and grows with you.
${bold}Usage: ${normal}Source this script in your shell. Use 'buddy --help' to see all commands.
"""  

                                                                                                                         

# Navigation Aliases
# Quickly navigate to common directories
alias desk='cd ~/Desktop'   # Go to Desktop directory
alias down='cd ~/Downloads' # Go to Downloads directory
alias docs='cd ~/Documents' # Go to Documents directory
alias pics='cd ~/Pictures'  # Go to Pictures directory
alias music='cd ~/Music'    # Go to Music directory
alias videos='cd ~/Videos'  # Go to Videos directory
alias root='cd /'           # Go to root directory
alias home='cd ~'           # Go to home directory

# Configuration Files
# Edit or reload shell configuration files
alias bashrc='nano ~/.bashrc'  # Edit .bashrc file
alias zshrc='nano ~/.zshrc'    # Edit .zshrc file
alias reload='source ~/.bashrc' # Reload .bashrc to apply changes
alias reloadz='source ~/.zshrc' # Reload .zshrc to apply changes

# System Locations
# Navigate to system directories
alias tmp='cd /tmp'                   # Go to /tmp directory
alias etc='cd /etc'                   # Go to /etc directory for configurations
alias trash='cd ~/.local/share/Trash/files' # Go to Trash directory
alias sshconf='cd ~/.ssh'             # Go to .ssh directory for SSH configurations

# Go Back Multiple Directories
# Navigate up multiple directory levels
alias ..='cd ..'      # Go up one directory
alias ...='cd ../..'  # Go up two directories
alias ....='cd ../../..' # Go up three directories

# Common Utilities
# Listing files with enhanced details
alias ls='ls --color=auto'  # List files with colors for easier readability
alias ll='ls -lh'           # List files with detailed information in human-readable format
alias la='ls -lha'          # List all files, including hidden ones, with details

# Clear and Exit
# Terminal utilities
alias cls='clear' # Clear the terminal screen
alias bye='exit'  # Exit the terminal

# System and Network Aliases
# Network and system-related commands
alias showWifiPass='sudo grep psk= /etc/NetworkManager/system-connections/*' # Show saved Wi-Fi passwords
alias updateSystem='sudo apt update && sudo apt upgrade -y'                  # Update and upgrade the system
alias ports='sudo lsof -i -P -n | grep LISTEN'                               # Show all running ports

# Git Utilities
# Simplify Git commands
alias gs='git status'  # Show the status of the current Git repository
alias gp='git push'   # Push committed changes to the remote repository

# Function Definitions

# CreateVenv Function
# Create a new Python virtual environment with a specified version and name
# Usage: CreateVenv <python_version> <venv_name>
CreateVenv() {
    if [ $# -ne 2 ]; then
        echo "Usage: CreateVenv <python_version> <venv_name>"
        return 1
    fi
    local version=$1
    local name=$2
    python$version -m venv $name
}

# myIP Function
# Display the current public IP address
# Usage: myIP
myIP() {
    curl -s http://ipinfo.io/ip
}

# weather Function
# Display weather information for a location (defaults to current location if no argument is given)
# Usage: weather [location]
weather() {
    if [ $# -eq 0 ]; then
        curl wttr.in
    else
        curl wttr.in/$1
    fi
}

# killPort Function
# Kill the process running on a specified port
# Usage: killPort <port_number>
killPort() {
    if [ $# -ne 1 ]; then
        echo "Usage: killPort <port_number>"
        return 1
    fi
    local port=$1
    local pid=$(lsof -t -i:$port)
    
    if [ -z "$pid" ]; then
        echo "No process found running on port $port"
    else
        echo "Killing process $pid running on port $port"
        kill -9 $pid
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
#  Sentient Companion Commands
# ═══════════════════════════════════════════════════════════════════════════════

# bb-evolve: Trigger the evolution engine manually
bb-evolve() {
    local engine_path=""
    # Check common install locations
    if [ -f "/usr/local/bin/bash_buddy_evolution.py" ]; then
        engine_path="/usr/local/bin/bash_buddy_evolution.py"
    elif [ -f "$(dirname "${BASH_SOURCE[0]:-$0}")/evolution_engine.py" ]; then
        engine_path="$(dirname "${BASH_SOURCE[0]:-$0}")/evolution_engine.py"
    elif [ -f "$HOME/.local/bin/bash_buddy_evolution.py" ]; then
        engine_path="$HOME/.local/bin/bash_buddy_evolution.py"
    fi

    if [ -z "$engine_path" ]; then
        echo -e "${red}⚠️  Evolution engine not found. Run the BashBuddy installer first.${nc}"
        return 1
    fi

    echo -e "${magenta}${bold}⚡ Evolving your companion...${normal}${nc}"
    python3 "$engine_path"
    echo -e "${green}${bold}✅ Evolution complete!${normal}${nc}"
    echo ""
    __bb_show_companion_status
}

# bb-status: Show companion status without the full banner
bb-status() {
    __bb_show_companion_status
}

# bb-reset: Reset companion to Hatchling state
bb-reset() {
    echo -e "${yellow}${bold}⚠️  This will reset your companion to Level 1 Hatchling!${normal}${nc}"
    echo -n "Are you sure? (y/N) "
    read -r confirm
    if [[ "$confirm" = "y" || "$confirm" = "Y" ]]; then
        rm -f "$__bb_state_file"
        echo -e "${green}✅ Companion reset. Run ${bold}bb-evolve${normal}${green} to start fresh!${nc}"
    else
        echo "Reset cancelled."
    fi
}

# Help Function
# Display usage information for all aliases and functions
# Usage: buddy --help
buddy() {
    if [[ "$1" = "-help" || "$1" = "--help" || "$1" = "help" ]]; then
        echo "${bold}Available Aliases and Functions:${normal}"
        
        echo ""
        echo "${bold}═══ Sentient Companion ═══${normal}"
        echo "bb-evolve      - Trigger the evolution engine to update your companion"
        echo "bb-status      - Display current companion status and stats"
        echo "bb-reset       - Reset companion back to Level 1 Hatchling"

        echo ""
        echo "${bold}═══ Navigation ═══${normal}"
        echo "desk           - Go to Desktop directory"
        echo "down           - Go to Downloads directory"
        echo "docs           - Go to Documents directory"
        echo "pics           - Go to Pictures directory"
        echo "music          - Go to Music directory"
        echo "videos         - Go to Videos directory"
        echo "root           - Go to root directory"
        echo "home           - Go to home directory"

        echo ""
        echo "${bold}═══ Configuration ═══${normal}"
        echo "bashrc         - Edit .bashrc file"
        echo "zshrc          - Edit .zshrc file"
        echo "reload         - Reload .bashrc to apply changes"
        echo "reloadz        - Reload .zshrc to apply changes"

        echo ""
        echo "${bold}═══ System Locations ═══${normal}"
        echo "tmp            - Go to /tmp directory"
        echo "etc            - Go to /etc directory for configurations"
        echo "trash          - Go to Trash directory"
        echo "sshconf        - Go to .ssh directory for SSH configurations"

        echo ""
        echo "${bold}═══ Navigation Shortcuts ═══${normal}"
        echo "..             - Go up one directory"
        echo "...            - Go up two directories"
        echo "....           - Go up three directories"

        echo ""
        echo "${bold}═══ Common Utilities ═══${normal}"
        echo "ls             - List files with colors for easier readability"
        echo "ll             - List files with detailed information in human-readable format"
        echo "la             - List all files, including hidden ones, with details"

        echo ""
        echo "${bold}═══ Terminal ═══${normal}"
        echo "cls            - Clear the terminal screen"
        echo "bye            - Exit the terminal"

        echo ""
        echo "${bold}═══ System & Network ═══${normal}"
        echo "showWifiPass   - Show saved Wi-Fi passwords"
        echo "updateSystem   - Update and upgrade the system"
        echo "ports          - Show all running ports"

        echo ""
        echo "${bold}═══ Git ═══${normal}"
        echo "gs             - Show the status of the current Git repository"
        echo "gp             - Push committed changes to the remote repository"
        
        echo ""
        echo "${bold}═══ Functions ═══${normal}"
        echo "CreateVenv     - Create a new Python virtual environment"
        echo "                Usage: CreateVenv <python_version> <venv_name>"
        echo "myIP           - Display the current public IP address"
        echo "                Usage: myIP"
        echo "weather        - Display weather information for a location"
        echo "                Usage: weather [location]"
        echo "killPort       - Kill the process running on a specified port"
        echo "                Usage: killPort <port_number>"
    else
        echo "Invalid option. Use 'buddy --help' to see available commands."
    fi
}
