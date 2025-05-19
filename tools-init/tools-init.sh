#!/bin/bash
set -e  # Exit immediately if a command exits with non-zero status

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "🚀 Initializing server tools setup..."

# System updates
echo "Updating system packages..."
apt update && apt upgrade -y
echo "✅ System packages updated"

# Install essential tools
echo "Installing developer tools..."
apt install vim-nox docker.io bat lsd -y
echo "✅ Developer tools installed"

# Configure aliases for all users
echo "Configuring system-wide aliases..."
if ! grep -q "alias upgrade=" /etc/bash.bashrc; then
    echo '# Server aliases' >> /etc/bash.bashrc
    echo 'alias upgrade="sudo apt update && sudo apt upgrade -y"' >> /etc/bash.bashrc
    echo "" >> /etc/bash.bashrc
fi

# Determine current user's home directory
if [ "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    USER_HOME=$HOME
fi

echo "Configuring user-specific shortcuts for $(basename "$USER_HOME")..."

# Make sure we're modifying the correct .bashrc file
USER_BASHRC="$USER_HOME/.bashrc"

# Check if bat is installed and add alias
if [ -f "/usr/bin/batcat" ]; then
    if ! grep -q "alias cat=\"/usr/bin/batcat\"" "$USER_BASHRC"; then
        echo '# Tool-specific aliases' >> "$USER_BASHRC"
        echo 'alias cat="/usr/bin/batcat"' >> "$USER_BASHRC"
        echo "Added bat alias"
    fi
fi

# Check if lsd is installed and add/replace alias
if [ -f "/usr/bin/lsd" ]; then
    # First, comment out any existing ls alias if present
    sed -i 's/^[[:space:]]*alias ls=/#alias ls=/' "$USER_BASHRC"
    
    # Then add our new alias if it doesn't exist
    if ! grep -q "alias ls=\"/usr/bin/lsd\"" "$USER_BASHRC"; then
        echo 'alias ls="/usr/bin/lsd"' >> "$USER_BASHRC"
        echo "Added lsd alias"
    fi
fi

# Add mkcd function if it doesn't exist
if ! grep -q "mkcd()" "$USER_BASHRC"; then
    cat << 'EOF' >> "$USER_BASHRC"

# Create and enter directory in one command
mkcd() {
  mkdir -p "$1" && cd "$1"
}
EOF
    echo "Added mkcd function"
fi

echo "✅ Aliases and functions configured"

# Enable Docker service
echo "Enabling Docker service..."
systemctl enable docker
systemctl start docker
echo "✅ Docker service started"

# Create a temporary script to apply changes in the user's shell
cat << 'EOF' > /tmp/apply-bash-changes.sh
#!/bin/bash
source ~/.bashrc
echo "✅ Bash configuration applied to current session"
EOF

chmod +x /tmp/apply-bash-changes.sh

echo "Applying bash configuration changes..."
if [ "$SUDO_USER" ]; then
    # If script is run with sudo, execute with the original user
    sudo -u "$SUDO_USER" bash -i /tmp/apply-bash-changes.sh
else
    # If script is run directly as root
    bash -i /tmp/apply-bash-changes.sh
fi

# Clean up
rm -f /tmp/apply-bash-changes.sh

echo "🎉 Tools initialization complete!"
echo "NOTE: If aliases aren't working, run 'source ~/.bashrc' or start a new terminal"
