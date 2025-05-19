# Tools Init

A Bash script for quickly setting up essential developer tools and configurations on a new Debian/Ubuntu server.

## Features

- Updates the system packages to the latest versions
- Installs common developer tools (vim-nox, docker.io, bat, lsd)
- Configures useful system-wide and user-specific aliases
- Adds productivity-enhancing shell functions
- Sets up Docker service to run at boot
- Applies configurations to the current session

## Requirements

- Debian-based Linux distribution (Ubuntu, Debian, etc.)
- Root privileges to run the script

## Installed Tools

|Tool|Description|
|---|---|
|vim-nox|Enhanced version of Vim with additional features|
|docker.io|Container platform for building and running applications|
|bat|Modern replacement for `cat` with syntax highlighting|
|lsd|Modern replacement for `ls` with icons and colors|

## Configured Aliases and Functions

|Name|Type|Command/Action|Scope|
|---|---|---|---|
|upgrade|Alias|`sudo apt update && sudo apt upgrade -y`|System-wide|
|cat|Alias|`/usr/bin/batcat`|User-specific|
|ls|Alias|`/usr/bin/lsd`|User-specific|
|mkcd|Function|Creates a directory and changes into it|User-specific|

## Usage

1. Download the script:
    
    bash
    
    ```bash
    wget https://raw.githubusercontent.com/your-username/devops-bash-scripts/main/tools-init/tools-init.sh
    ```
    
2. Make it executable:
    
    bash
    
    ```bash
    chmod +x tools-init.sh
    ```
    
3. Run the script with root privileges:
    
    bash
    
    ```bash
    sudo ./tools-init.sh
    ```
    
4. The script will:
    - Update and upgrade all system packages
    - Install the specified developer tools
    - Configure aliases for easier system management
    - Add productivity-enhancing shell functions
    - Enable and start Docker service
    - Apply bash configuration changes to the current session

## Custom Functions

### mkcd

Creates a directory and immediately changes into it.

Usage:

bash

```bash
mkcd new_project_directory
```

This will create "new_project_directory" and change into it in one command.

## Example Output

```
🚀 Initializing server tools setup...
Updating system packages...
✅ System packages updated
Installing developer tools...
✅ Developer tools installed
Configuring system-wide aliases...
Configuring user-specific shortcuts...
Added bat alias
Added lsd alias
Added mkcd function
✅ Aliases and functions configured
Enabling Docker service...
✅ Docker service started
Applying bash configuration changes...
✅ Bash configuration applied to current session
🎉 Tools initialization complete!
NOTE: If aliases aren't working, run 'source ~/.bashrc' or start a new terminal
```

## Implementation Details

- The script intelligently handles existing aliases, commenting out conflicts
- Tool-specific aliases are only created if the tools are installed successfully
- Uses proper user context when applying changes to bashrc
- Provides clear feedback and fallback instructions

## Customization

You can easily customize this script to include additional tools or configurations:

- Add more packages to the `apt install` line
- Configure additional aliases in the `/etc/bash.bashrc` section
- Add more shell functions to increase productivity
- Add more services to enable at boot

## Notes

- The script must be run as root to install packages and configure system-wide settings
- Some changes may require starting a new terminal session to take full effect
