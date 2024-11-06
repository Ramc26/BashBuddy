#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

# Bash Buddy ASCII Logo
echo """

░▒▓███████▓▒░ ░▒▓██████▓▒░ ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░░▒▓████████▓▒░░▒▓██████▓▒░░▒▓████████▓▒░      ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░     
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░     
░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░   ░▒▓█▓▒░     
                                                                                                                              
"""
# Welcome Message
echo -e "✨ \e[1mHey there, coding superstar! You've just leveled up with Bash Buddy! ✨\e[0m"
echo -e "\e[1mYour personal terminal sidekick is now installed and ready to work its magic. 🚀\e[0m"
echo -e "\e[1mRun 'BashBuddy -help' to explore all the cool tricks and turbocharge your productivity! 💻🔥\e[0m"
echo -e "\e[1mMay your coding be bug-free and your terminal always obedient! 😄🤖\e[0m"
echo """
${bold}Author: ${normal}RamBikkina ${bold}<<<--->>> ${bold}Email: ${normal}rambikkina@yahoo.com ${bold}<<<--->>> ${bold}Version: ${normal}1.0
${bold}Description: ${normal}Bash Buddy is here to make your terminal life easier with a collection of handy aliases and functions.
${bold}Usage: ${normal}Source this script in your shell to access all aliases and functions. Use 'BashBuddy -help' to see all available commands.
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

# Help Function
# Display usage information for all aliases and functions
# Usage: BashBuddy -help  
BashBuddy() {
    if [ "$1" == "-help" ]; then
        echo "Available Aliases and Functions:"
        echo "\nAliases:"
        echo "desk           - Go to Desktop directory"
        echo "down           - Go to Downloads directory"
        echo "docs           - Go to Documents directory"
        echo "pics           - Go to Pictures directory"
        echo "music          - Go to Music directory"
        echo "videos         - Go to Videos directory"
        echo "root           - Go to root directory"
        echo "home           - Go to home directory"
        echo "bashrc         - Edit .bashrc file"
        echo "zshrc          - Edit .zshrc file"
        echo "reload         - Reload .bashrc to apply changes"
        echo "reloadz        - Reload .zshrc to apply changes"
        echo "tmp            - Go to /tmp directory"
        echo "etc            - Go to /etc directory for configurations"
        echo "trash          - Go to Trash directory"
        echo "sshconf        - Go to .ssh directory for SSH configurations"
        echo "..             - Go up one directory"
        echo "...            - Go up two directories"
        echo "....           - Go up three directories"
        echo "ls             - List files with colors for easier readability"
        echo "ll             - List files with detailed information in human-readable format"
        echo "la             - List all files, including hidden ones, with details"
        echo "cls            - Clear the terminal screen"
        echo "bye            - Exit the terminal"
        echo "showWifiPass   - Show saved Wi-Fi passwords"
        echo "updateSystem   - Update and upgrade the system"
        echo "ports          - Show all running ports"
        echo "gs             - Show the status of the current Git repository"
        echo "gp             - Push committed changes to the remote repository"
        
        echo "\nFunctions:"
        echo "CreateVenv     - Create a new Python virtual environment"
        echo "                Usage: CreateVenv <python_version> <venv_name>"
        echo "myIP           - Display the current public IP address"
        echo "                Usage: myIP"
        echo "weather        - Display weather information for a location"
        echo "                Usage: weather [location]"
        echo "killPort       - Kill the process running on a specified port"
        echo "                Usage: killPort <port_number>"
    else
        echo "Invalid option. Use 'BashBuddy -help' to see available commands."
    fi
}
