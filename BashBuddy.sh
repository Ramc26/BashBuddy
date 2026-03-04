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
gray='\033[0;90m'
nc='\033[0m' # No Color

# ═══════════════════════════════════════════════════════════════════════════════
#  BashBuddy — Sentient Terminal Companion
# ═══════════════════════════════════════════════════════════════════════════════

__bb_state_file="$HOME/.bash_buddy_state.json"

# ─── Animated Startup ────────────────────────────────────────────────────────

__bb_animate_text() {
    local text="$1"
    local delay="${2:-0.015}"
    local i
    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep "$delay"
    done
    echo ""
}

__bb_scan_animation() {
    local label="$1"
    local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i
    for ((i=0; i<10; i++)); do
        printf "\r  ${cyan}${frames[$i]}${nc} ${label}..."
        sleep 0.06
    done
    printf "\r  ${green}✓${nc} ${label}   \n"
}

__bb_startup() {
    echo ""
    # Animated logo reveal
    echo -e "${cyan}${bold}"
    local logo_lines=(
        "  ____            _       ____            _     _"
        " | __ )  __ _ ___| |__   | __ ) _   _  __| | __| |_   _"
        " |  _ \\ / _\` / __| '_ \\  |  _ \\| | | |/ _\` |/ _\` | | | |"
        " | |_) | (_| \\__ \\ | | | | |_) | |_| | (_| | (_| | |_| |"
        " |____/ \\__,_|___/_| |_| |____/ \\__,_|\\__,_|\\__,_|\\__, |"
        "                                                   |___/"
    )
    for line in "${logo_lines[@]}"; do
        echo "$line"
        sleep 0.04
    done
    echo -e "${nc}"

    # Scanning animation
    __bb_scan_animation "Initializing sentient layer"
    __bb_scan_animation "Reading evolution state"

    # Show animated companion status
    __bb_show_companion_animated

    # Welcome
    echo ""
    __bb_animate_text "  ✨ Your sentient terminal companion is awake." 0.02
    echo -e "  ${dim}Type ${normal}${bold}buddy --help${normal}${dim} for commands  •  ${normal}${bold}bb-evolve${normal}${dim} to level up${normal}"
    echo ""
}

# ─── JSON Reader ─────────────────────────────────────────────────────────────

__bb_read_json() {
    local key="$1"
    if [ -f "$__bb_state_file" ]; then
        python3 -c "
import json
try:
    with open('$__bb_state_file') as f:
        d = json.load(f)
    print(d.get('$key', ''))
except:
    print('')
" 2>/dev/null
    fi
}

# ─── Clean Companion Characters ─────────────────────────────────────────────

__bb_get_companion() {
    local mode="$1"
    local level="$2"
    local tier=1

    if [ "$level" -ge 25 ] 2>/dev/null; then
        tier=3
    elif [ "$level" -ge 10 ] 2>/dev/null; then
        tier=2
    fi

    case "$mode" in
        "The Architect")
            # Blueprint/building — represents structuring code
            if [ $tier -eq 1 ]; then
                echo -e "${cyan}"
                echo "          ⌂          "
                echo "         /█\\         "
                echo "        / █ \\        "
                echo "       /█████\\       "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${cyan}"
                echo "          △          "
                echo "         /█\\         "
                echo "        /▓▓▓\\        "
                echo "       /█████\\       "
                echo "      │ ◫   ◫ │      "
                echo "      └───⌂───┘      "
                echo -e "${nc}"
            else
                echo -e "${cyan}"
                echo "        ✦   ✦        "
                echo "         ╲△╱         "
                echo "         /█\\         "
                echo "        /▓▓▓\\        "
                echo "       /█████\\       "
                echo "      ╔═══════╗      "
                echo "      ║ ◫ ⌂ ◫ ║      "
                echo "      ║ ◫   ◫ ║      "
                echo "      ╚══╦═╦══╝      "
                echo -e "${nc}"
            fi
            ;;
        "The Explorer")
            # Compass/adventurer — represents navigating the filesystem
            if [ $tier -eq 1 ]; then
                echo -e "${green}"
                echo "        ╭─╮         "
                echo "        │◉│         "
                echo "       ╭┴─┴╮        "
                echo "       ╰┬─┬╯ ⌐     "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${green}"
                echo "       ╭───╮        "
                echo "       │◉ ◉│        "
                echo "       ╰─┬─╯        "
                echo "      ╭──┴──╮ ⌐    "
                echo "      │ ▪▪▪ │/     "
                echo "      ╰──┬──╯       "
                echo "        ╱ ╲         "
                echo -e "${nc}"
            else
                echo -e "${green}"
                echo "      ★  N  ★       "
                echo "       ╭───╮        "
                echo "       │◉ ◉│ ☆     "
                echo "     W ╰─┬─╯ E     "
                echo "      ╭──┴──╮ ⌐    "
                echo "      │ ▪▪▪ │/📜   "
                echo "      ╰──┬──╯       "
                echo "       ╱   ╲        "
                echo "      ╱  S  ╲       "
                echo -e "${nc}"
            fi
            ;;
        "The Builder")
            # Anvil & hammer — represents building/compiling
            if [ $tier -eq 1 ]; then
                echo -e "${yellow}"
                echo "         🔨          "
                echo "       ╭────╮        "
                echo "       │▓▓▓▓│        "
                echo "       ╰────╯        "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${yellow}"
                echo "        ╲🔨╱         "
                echo "       ╭────╮        "
                echo "     ╭─┤▓▓▓▓├─╮     "
                echo "     │ ╰────╯ │     "
                echo "     │  ⚙  ⚙  │     "
                echo "     ╰────────╯     "
                echo -e "${nc}"
            else
                echo -e "${yellow}"
                echo "      ⚡╲🔨╱⚡       "
                echo "       ╭────╮        "
                echo "     ╭─┤▓▓▓▓├─╮     "
                echo "   ╭─┤ ╰────╯ ├─╮   "
                echo "   │ │ ⚙ ▓▓ ⚙ │ │   "
                echo "   │ ╰────────╯ │   "
                echo "   ╰──┤  ▓▓  ├──╯   "
                echo "      ╰──────╯      "
                echo "     ═══════════     "
                echo -e "${nc}"
            fi
            ;;
        "The Destroyer")
            # Skull — represents destructive/powerful commands
            if [ $tier -eq 1 ]; then
                echo -e "${red}"
                echo "        ╭───╮        "
                echo "        │◉ ◉│        "
                echo "        │ ▼ │        "
                echo "        ╰───╯        "
                echo -e "${nc}"
            elif [ $tier -eq 2 ]; then
                echo -e "${red}"
                echo "      ╭─────╮       "
                echo "      │◉   ◉│       "
                echo "      │  ▼  │       "
                echo "      │╥╥╥╥╥│       "
                echo "      ╰─────╯       "
                echo "       🔥�🔥       "
                echo -e "${nc}"
            else
                echo -e "${red}"
                echo "    🔥  ╭─────╮  🔥 "
                echo "    ╱  ╭┤     ├╮  ╲ "
                echo "   ╱   │◉     ◉│   ╲"
                echo "       │   ▼   │     "
                echo "       │╥╥╥╥╥╥╥│     "
                echo "       ╰┬─────┬╯     "
                echo "    ⚡  ╱ ╲   ╱ ╲  ⚡ "
                echo "   🔥🔥🔥🔥🔥🔥🔥🔥"
                echo -e "${nc}"
            fi
            ;;
        *)
            echo "        🤖            "
            ;;
    esac
}

# ─── Animated XP Bar ────────────────────────────────────────────────────────

__bb_animated_bar() {
    local xp_in="$1"
    local bar_len=20
    local filled=$((xp_in * bar_len / 100))
    local empty=$((bar_len - filled))

    # Animated shimmer: last filled block pulses
    local bar=""
    local i
    for ((i=0; i<filled; i++)); do
        if [ $i -eq $((filled - 1)) ] && [ $filled -gt 0 ]; then
            bar+="▓"  # Shimmer on leading edge
        else
            bar+="█"
        fi
    done
    for ((i=0; i<empty; i++)); do bar+="░"; done
    echo "$bar"
}

# ─── Companion Status Display (animated version) ────────────────────────────

__bb_show_companion_animated() {
    if [ ! -f "$__bb_state_file" ]; then
        echo ""
        echo -e "  ${dim}🥚 No evolution data yet. Run ${normal}${bold}bb-evolve${normal}${dim} to awaken your companion!${normal}"
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

    [ -z "$mode" ] && mode="Unknown"
    [ -z "$mode_icon" ] && mode_icon="🤖"
    [ -z "$level" ] && level=1
    [ -z "$xp" ] && xp=0
    [ -z "$stage" ] && stage="Hatchling"
    [ -z "$total" ] && total=0
    [ -z "$streak" ] && streak=0

    local xp_in_level=$((xp % 100))
    local bar=$(__bb_animated_bar "$xp_in_level")

    # Mode color
    local mode_color="$white"
    case "$mode" in
        "The Architect") mode_color="$cyan" ;;
        "The Explorer") mode_color="$green" ;;
        "The Builder") mode_color="$yellow" ;;
        "The Destroyer") mode_color="$red" ;;
    esac

    # Animated panel reveal
    echo ""
    echo -e "  ${gray}╭──────────────────────────────────────╮${nc}"
    sleep 0.03
    echo -e "  ${gray}│${nc}  ${bold}⚡ COMPANION STATUS${normal}                 ${gray}│${nc}"
    sleep 0.03
    echo -e "  ${gray}├──────────────────────────────────────┤${nc}"
    sleep 0.03

    # Show companion art with slight animation (line by line delay)
    local art_output
    art_output=$(__bb_get_companion "$mode" "$level")
    while IFS= read -r art_line; do
        echo "$art_line"
        sleep 0.03
    done <<< "$art_output"

    # Stats with typewriter-ish feel
    sleep 0.05
    echo -e "  ${gray}│${nc}  ${mode_color}${bold}${mode_icon}  ${mode}${normal}"
    sleep 0.05
    echo -e "  ${gray}│${nc}  ⭐ Level ${bold}${level}${normal} — ${magenta}${stage}${normal}"
    sleep 0.05
    echo -e "  ${gray}│${nc}  [${green}${bar}${nc}] ${xp_in_level}/100 XP"
    sleep 0.05
    echo -e "  ${gray}│${nc}  📊 Commands analyzed: ${bold}${total}${normal}"

    if [ "$streak" -ge 3 ] 2>/dev/null; then
        sleep 0.05
        echo -e "  ${gray}│${nc}  🔥 Streak: ${bold}${streak}${normal} ${yellow}(1.5× XP!)${normal}"
    fi

    sleep 0.03
    echo -e "  ${gray}╰──────────────────────────────────────╯${nc}"
    echo ""
}

# Show static version (no animation, for fast checks)
__bb_show_companion_static() {
    if [ ! -f "$__bb_state_file" ]; then
        echo -e "  ${dim}🥚 No evolution data yet. Run ${normal}${bold}bb-evolve${normal}${dim} to awaken your companion!${normal}"
        return
    fi

    local mode=$(__bb_read_json "mode")
    local mode_icon=$(__bb_read_json "mode_icon")
    local level=$(__bb_read_json "level")
    local xp=$(__bb_read_json "xp")
    local stage=$(__bb_read_json "evolution_stage")
    local total=$(__bb_read_json "total_commands_analyzed")
    local streak=$(__bb_read_json "streak_count")

    [ -z "$mode" ] && mode="Unknown"
    [ -z "$mode_icon" ] && mode_icon="🤖"
    [ -z "$level" ] && level=1
    [ -z "$xp" ] && xp=0
    [ -z "$stage" ] && stage="Hatchling"
    [ -z "$total" ] && total=0
    [ -z "$streak" ] && streak=0

    local xp_in_level=$((xp % 100))
    local bar=$(__bb_animated_bar "$xp_in_level")

    local mode_color="$white"
    case "$mode" in
        "The Architect") mode_color="$cyan" ;;
        "The Explorer") mode_color="$green" ;;
        "The Builder") mode_color="$yellow" ;;
        "The Destroyer") mode_color="$red" ;;
    esac

    echo ""
    echo -e "  ${gray}╭──────────────────────────────────────╮${nc}"
    echo -e "  ${gray}│${nc}  ${bold}⚡ COMPANION STATUS${normal}                  ${gray}│${nc}"
    echo -e "  ${gray}├──────────────────────────────────────┤${nc}"
    __bb_get_companion "$mode" "$level"
    echo -e "  ${gray}│${nc}  ${mode_color}${bold}${mode_icon}  ${mode}${normal}"
    echo -e "  ${gray}│${nc}  ⭐ Level ${bold}${level}${normal} — ${magenta}${stage}${normal}"
    echo -e "  ${gray}│${nc}  [${green}${bar}${nc}] ${xp_in_level}/100 XP"
    echo -e "  ${gray}│${nc}  📊 Commands analyzed: ${bold}${total}${normal}"
    if [ "$streak" -ge 3 ] 2>/dev/null; then
        echo -e "  ${gray}│${nc}  🔥 Streak: ${bold}${streak}${normal} ${yellow}(1.5× XP!)${normal}"
    fi
    echo -e "  ${gray}╰──────────────────────────────────────╯${nc}"
    echo ""
}

# ─── Run animated startup ───────────────────────────────────────────────────

__bb_startup

# ─── RPROMPT: Animated Real-Time Status ──────────────────────────────────────

__bb_rprompt_frame=0
__bb_rprompt_spinners=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
__bb_rprompt_pulse=("█" "▓" "▒" "░" "▒" "▓")

__bb_build_rprompt() {
    if [ ! -f "$__bb_state_file" ]; then
        echo "🥚 bb-evolve"
        return
    fi

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
    streak = d.get('streak_count', 0)
    xp_in = xp % 100
    frame = $__bb_rprompt_frame
    # Animated bar with pulse effect on leading edge
    bar_len = 10
    filled = int(xp_in / 100 * bar_len)
    pulse_chars = ['█', '▓', '▒', '░', '▒', '▓']
    pulse = pulse_chars[frame % len(pulse_chars)]
    bar = '█' * max(0, filled - 1)
    if filled > 0:
        bar += pulse
    bar += '░' * (bar_len - filled)
    # Animated spinner
    spinners = '⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    spin = spinners[frame % len(spinners)]
    streak_str = ' 🔥' if streak >= 3 else ''
    print(f'{spin} {mode_icon} L{level} {stage} [{bar}] {xp_in}/100{streak_str}')
except:
    print('🤖 ...')
" 2>/dev/null)

    echo "$rprompt_data"
}

__bb_update_rprompt() {
    (( __bb_rprompt_frame++ ))
    RPROMPT=$(__bb_build_rprompt)
}

# Register RPROMPT updater (Zsh)
if [[ -n "$ZSH_VERSION" ]]; then
    if [[ ! " ${precmd_functions[*]} " =~ " __bb_update_rprompt " ]]; then
        precmd_functions+=(__bb_update_rprompt)
    fi
fi

# ═══════════════════════════════════════════════════════════════════════════════
#  Aliases
# ═══════════════════════════════════════════════════════════════════════════════

# Navigation
alias desk='cd ~/Desktop'
alias down='cd ~/Downloads'
alias docs='cd ~/Documents'
alias pics='cd ~/Pictures'
alias music='cd ~/Music'
alias videos='cd ~/Videos'
alias root='cd /'
alias home='cd ~'

# Configuration Files
alias bashrc='nano ~/.bashrc'
alias zshrc='nano ~/.zshrc'
alias reload='source ~/.bashrc'
alias reloadz='source ~/.zshrc'

# System Locations
alias tmp='cd /tmp'
alias etc='cd /etc'
alias trash='cd ~/.local/share/Trash/files'
alias sshconf='cd ~/.ssh'

# Go Back
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Listing
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'

# Terminal
alias cls='clear'
alias bye='exit'

# System & Network
alias showWifiPass='sudo grep psk= /etc/NetworkManager/system-connections/*'
alias updateSystem='sudo apt update && sudo apt upgrade -y'
alias ports='sudo lsof -i -P -n | grep LISTEN'

# Git
alias gs='git status'
alias gp='git push'

# ═══════════════════════════════════════════════════════════════════════════════
#  Functions
# ═══════════════════════════════════════════════════════════════════════════════

CreateVenv() {
    if [ $# -ne 2 ]; then
        echo "Usage: CreateVenv <python_version> <venv_name>"
        return 1
    fi
    local version=$1
    local name=$2
    python$version -m venv $name
}

myIP() {
    curl -s http://ipinfo.io/ip
}

weather() {
    if [ $# -eq 0 ]; then
        curl wttr.in
    else
        curl wttr.in/$1
    fi
}

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

bb-evolve() {
    local engine_path=""
    if [ -f "/usr/local/bin/bash_buddy_evolution.py" ]; then
        engine_path="/usr/local/bin/bash_buddy_evolution.py"
    elif [ -f "$(dirname "${BASH_SOURCE[0]:-$0}")/evolution_engine.py" ]; then
        engine_path="$(dirname "${BASH_SOURCE[0]:-$0}")/evolution_engine.py"
    elif [ -f "$HOME/.local/bin/bash_buddy_evolution.py" ]; then
        engine_path="$HOME/.local/bin/bash_buddy_evolution.py"
    fi

    if [ -z "$engine_path" ]; then
        echo -e "${red}⚠️  Evolution engine not found. Run the installer first.${nc}"
        return 1
    fi

    # Animated evolution
    local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i
    for ((i=0; i<15; i++)); do
        printf "\r  ${magenta}${frames[$((i % 10))]}${nc} ${bold}Evolving companion...${normal}"
        sleep 0.08
    done
    
    python3 "$engine_path" --quiet 2>/dev/null
    printf "\r  ${green}✓${nc} ${bold}Evolution complete!${normal}       \n"
    echo ""
    __bb_show_companion_static
}

bb-status() {
    __bb_show_companion_static
}

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

buddy() {
    if [[ "$1" = "-help" || "$1" = "--help" || "$1" = "help" ]]; then
        echo ""
        echo "${bold}  ⚡ BashBuddy — Sentient Terminal Companion${normal}"
        echo ""
        
        echo "  ${bold}═══ Companion ═══${normal}"
        echo "  bb-evolve      Trigger evolution engine"
        echo "  bb-status      Show companion stats"
        echo "  bb-reset       Reset to Level 1 Hatchling"

        echo ""
        echo "  ${bold}═══ Navigation ═══${normal}"
        echo "  desk           ~/Desktop"
        echo "  down           ~/Downloads"
        echo "  docs           ~/Documents"
        echo "  pics           ~/Pictures"
        echo "  music          ~/Music"
        echo "  videos         ~/Videos"
        echo "  root           /"
        echo "  home           ~"
        echo "  .. / ... / ....   Up 1/2/3 directories"

        echo ""
        echo "  ${bold}═══ Config ═══${normal}"
        echo "  bashrc/zshrc   Edit shell config"
        echo "  reload/reloadz Reload shell config"

        echo ""
        echo "  ${bold}═══ System ═══${normal}"
        echo "  ports          Show listening ports"
        echo "  myIP           Public IP address"
        echo "  weather [city] Weather report"
        echo "  killPort <N>   Kill process on port"
        echo "  showWifiPass   Saved Wi-Fi passwords"

        echo ""
        echo "  ${bold}═══ Git ═══${normal}"
        echo "  gs             git status"
        echo "  gp             git push"

        echo ""
        echo "  ${bold}═══ Utilities ═══${normal}"
        echo "  ll / la        Detailed / all file listing"
        echo "  cls            Clear terminal"
        echo "  bye            Exit terminal"
        echo "  CreateVenv <ver> <name>   New Python venv"
        echo ""
    else
        echo "Use 'buddy --help' to see available commands."
    fi
}
