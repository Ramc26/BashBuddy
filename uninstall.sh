#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
#  BashBuddy Uninstaller — Goodbye, old friend 😢
# ═══════════════════════════════════════════════════════════════════════════════

bold=$(tput bold)
normal=$(tput sgr0)
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
cyan='\033[0;36m'
gray='\033[0;90m'
nc='\033[0m'

INSTALL_PATH="/usr/local/bin/BashBuddy.sh"
ENGINE_INSTALL_PATH="/usr/local/bin/bash_buddy_evolution.py"
STATE_FILE="$HOME/.bash_buddy_state.json"

echo ""
echo -e "${red}${bold}"
echo "  ╔══════════════════════════════════════════╗"
echo "  ║     BashBuddy Uninstaller                ║"
echo "  ╚══════════════════════════════════════════╝"
echo -e "${normal}${nc}"

# Show current companion one last time
if [ -f "$STATE_FILE" ]; then
    echo -e "  ${gray}Your companion's final stats:${nc}"
    if command -v python3 &>/dev/null; then
        python3 -c "
import json
try:
    with open('$STATE_FILE') as f:
        d = json.load(f)
    icon = d.get('mode_icon', '🤖')
    mode = d.get('mode', '?')
    level = d.get('level', 1)
    stage = d.get('evolution_stage', '?')
    total = d.get('total_commands_analyzed', 0)
    print(f'  {icon}  {mode} — Level {level} ({stage})')
    print(f'  📊 {total} commands shared together.')
except:
    pass
" 2>/dev/null
    fi
    echo ""
fi

echo -e "${yellow}${bold}  ⚠️  This will remove:${normal}"
echo -e "  • $INSTALL_PATH"
echo -e "  • $ENGINE_INSTALL_PATH"
echo -e "  • $STATE_FILE"
echo -e "  • BashBuddy lines from your shell config (~/.zshrc or ~/.bashrc)"
echo ""
echo -n "  Are you sure you want to say goodbye? (y/N) "
read -r confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo ""
    echo -e "  ${green}✓ Uninstall cancelled. Your buddy lives on! 🎉${nc}"
    echo ""
    exit 0
fi

echo ""

# ─── Step 1: Remove installed scripts ───────────────────────────────────────

echo -e "${bold}[1/3]${normal} Removing scripts..."

if [ -f "$INSTALL_PATH" ]; then
    sudo rm -f "$INSTALL_PATH"
    echo -e "  ${green}✓${nc} Removed $INSTALL_PATH"
else
    echo -e "  ${gray}–${nc} $INSTALL_PATH not found (already removed)"
fi

if [ -f "$ENGINE_INSTALL_PATH" ]; then
    sudo rm -f "$ENGINE_INSTALL_PATH"
    echo -e "  ${green}✓${nc} Removed $ENGINE_INSTALL_PATH"
else
    echo -e "  ${gray}–${nc} $ENGINE_INSTALL_PATH not found (already removed)"
fi

# ─── Step 2: Remove state file ──────────────────────────────────────────────

echo -e "\n${bold}[2/3]${normal} Removing companion state..."

if [ -f "$STATE_FILE" ]; then
    rm -f "$STATE_FILE"
    echo -e "  ${green}✓${nc} Removed $STATE_FILE"
else
    echo -e "  ${gray}–${nc} $STATE_FILE not found (already removed)"
fi

# Remove __pycache__ if it exists in the project dir
if [ -d "$(dirname "$0")/__pycache__" ]; then
    rm -rf "$(dirname "$0")/__pycache__"
    echo -e "  ${green}✓${nc} Cleaned up __pycache__"
fi

# ─── Step 3: Clean shell config ─────────────────────────────────────────────

echo -e "\n${bold}[3/3]${normal} Cleaning shell configuration..."

clean_shell_config() {
    local config_file="$1"
    local config_name="$2"

    if [ ! -f "$config_file" ]; then
        return
    fi

    # Check if there's anything BashBuddy-related in the config
    if ! grep -q -E "(BashBuddy|bash_buddy|__bb_)" "$config_file"; then
        echo -e "  ${gray}–${nc} No BashBuddy entries found in ~/$config_name"
        return
    fi

    # Create a backup
    cp "$config_file" "${config_file}.bb_backup"
    echo -e "  ${green}✓${nc} Backed up ~/$config_name → ~/${config_name}.bb_backup"

    # Remove BashBuddy-related lines:
    # - source /usr/local/bin/BashBuddy.sh
    # - # BashBuddy comments
    # - __bb_ function blocks
    # - precmd_functions+=(__bb_precmd) etc.
    python3 -c "
import re

with open('$config_file', 'r') as f:
    content = f.read()

# Remove the BashBuddy source line and its comment
content = re.sub(r'\n*# BashBuddy[^\n]*\nsource /usr/local/bin/BashBuddy\.sh\n?', '\n', content)
content = re.sub(r'\n*source /usr/local/bin/BashBuddy\.sh\n?', '\n', content)

# Remove the evolution hook block
content = re.sub(
    r'\n*# BashBuddy Evolution Hook[^\n]*\n'
    r'__bb_cmd_count=0\n'
    r'__bb_\w+\(\) \{\n'
    r'(?:.*\n)*?'
    r'\}\n'
    r'(?:precmd_functions\+=\(__bb_\w+\)\n?|PROMPT_COMMAND=\"[^\"]*\"\n?)',
    '\n', content
)

# Clean up multiple blank lines
content = re.sub(r'\n{3,}', '\n\n', content)

with open('$config_file', 'w') as f:
    f.write(content.strip() + '\n')
" 2>/dev/null

    echo -e "  ${green}✓${nc} Cleaned BashBuddy entries from ~/$config_name"
}

clean_shell_config "$HOME/.zshrc" ".zshrc"
clean_shell_config "$HOME/.bashrc" ".bashrc"

# ─── Done ────────────────────────────────────────────────────────────────────

echo ""
echo -e "${green}${bold}  ╔══════════════════════════════════════════════╗"
echo -e "  ║  ✅ BashBuddy has been uninstalled.            ║"
echo -e "  ╚══════════════════════════════════════════════╝${normal}${nc}"
echo ""
echo -e "  ${gray}Your shell config backup is at ~/.zshrc.bb_backup${nc}"
echo -e "  ${gray}(or ~/.bashrc.bb_backup)${nc}"
echo ""
echo -e "  We'll miss you. Open a new terminal and it'll be like"
echo -e "  we were never here... 😢"
echo ""
echo -e "  ${dim}To reinstall: ./install.sh${normal}"
echo ""
