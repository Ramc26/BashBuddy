# Bash Buddy

## Overview
**Bash Buddy** is your personal terminal assistant designed to enhance productivity and simplify command-line usage. It provides a collection of useful aliases and functions that make navigating the filesystem, managing Git repositories, working with Python environments, and more much easier and faster. 🚀💻

## Features
- **Navigation Shortcuts**: Quickly navigate to common directories like Desktop, Downloads, etc.
- **Configuration Helpers**: Easily edit and reload your shell configuration files.
- **System Utilities**: View running ports, update your system, and clear your terminal with simple commands.
- **Git Utilities**: Simplified commands for Git status and pushing changes.
- **Python Virtual Environments**: Easily create Python virtual environments with specified versions.
- **Network Utilities**: Display your public IP and show saved Wi-Fi passwords.
- **Kill Process by Port**: Kill any process running on a specific port.

## Installation
To install Bash Buddy, simply clone this repository and run the installer script.

```bash
# Clone the repository
git clone https://github.com/Ramc26/BashBuddy.git

# Navigate to the BashBuddy directory
cd BashBuddy

# Run the installer script
chmod +x install.sh
./install.sh
```

### Requirements
- **Bash** (or another POSIX-compatible shell)
- **Python** (for virtual environment creation)
- **Admin privileges** (for installation in `/usr/local/bin`)

## Usage
Once installed, Bash Buddy will be available in all new terminal sessions. You can use the following command to explore all available aliases and functions:

```bash
BashBuddy -help
```

### Example Commands
- **Navigate to Downloads**: `down`
- **List all files with details**: `ll`
- **Create a Python virtual environment**: `CreateVenv 3.8 myenv`
- **Show the status of a Git repository**: `gs`
- **Kill process running on port 8080**: `killPort 8080`

## Uninstallation
To uninstall Bash Buddy, remove the sourcing line from your `.bashrc` and delete the script from `/usr/local/bin/`:

```bash
# Remove the sourcing line from .bashrc
nano ~/.bashrc  # Remove the line 'source /usr/local/bin/BashBuddy.sh'

# Delete the script
sudo rm /usr/local/bin/BashBuddy.sh

# Reload .bashrc\source ~/.bashrc
```

## Contributing
Contributions are welcome! Feel free to fork the project, create a new branch, and submit a pull request. If you have ideas for new features or improvements, open an issue to discuss them.

## License
This project is licensed under the MIT License. See the `LICENSE` file for more information.

## Author
- **Ram Bikkina**
- [Email](mailto:rambikkina@yahoo.com)

## Acknowledgements
Thanks to everyone who contributed directly or indirectly to make Bash Buddy a reality. Happy coding! 😄
