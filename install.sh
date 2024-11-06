#!/bin/bash

# BashBuddy Installer Script
# Author: Ram Bikkina
# Email: rambikkina@yahoo.com
# Version: 1.0
# Description: This script installs BashBuddy by copying it to a location and adding it to the shell configuration for easy access.

# Define installation paths
BASHBUDDY_SCRIPT="BashBuddy.sh"
INSTALL_PATH="/usr/local/bin/BashBuddy.sh"

# Check if BashBuddy script exists
if [ ! -f "$BASHBUDDY_SCRIPT" ]; then
    echo "Error: $BASHBUDDY_SCRIPT not found in the current directory. Please make sure the script is present."
    exit 1
fi

# Copy BashBuddy script to /usr/local/bin
sudo cp "$BASHBUDDY_SCRIPT" "$INSTALL_PATH"
if [ $? -ne 0 ]; then
    echo "Error: Failed to copy BashBuddy script to $INSTALL_PATH. Please check your permissions."
    exit 1
fi

# Add sourcing command to .bashrc
if ! grep -q "source $INSTALL_PATH" ~/.bashrc; then
    echo "source $INSTALL_PATH" >> ~/.bashrc
    echo "BashBuddy has been added to your .bashrc and will be available in all new terminal sessions."
fi

# Source the script in the current session
echo "Sourcing BashBuddy now..."
source "$INSTALL_PATH"

# Display final message
echo -e "\n🎉 \e[1mBashBuddy has been successfully installed! 🎉\e[0m"
echo -e "\e[1mYour personal terminal assistant is ready to boost your productivity. 🚀\e[0m"
echo -e "\e[1mTo see all available commands, run 'BashBuddy -help' 💻✨\e[0m"
echo -e "\e[1mHappy coding! 😄👍\e[0m"
