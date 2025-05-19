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
cat << 'EOF' >> /etc/bash.bashrc

# Server aliases
alias upgrade="sudo apt update && sudo apt upgrade -y"
EOF

# Configure user-specific aliases and functions
echo "Configuring user-specific shortcuts..."
cat << 'EOF' >> ~/.bashrc

# Tool-specific aliases
EOF

if [ -f "/usr/bin/batcat" ]; then
    echo 'alias cat="/usr/bin/batcat"' >> ~/.bashrc
fi

if [ -f "/usr/bin/lsd" ]; then
    echo 'alias ls="/usr/bin/lsd"' >> ~/.bashrc
fi

# Add useful functions
cat << 'EOF' >> ~/.bashrc

# Create and enter directory in one command
mkcd() {
  mkdir -p "$1" && cd "$1"
}
EOF

echo "✅ Aliases and functions configured"

# Enable Docker service
echo "Enabling Docker service..."
systemctl enable docker
systemctl start docker
echo "✅ Docker service started"

# Apply bash changes to current session
echo "Applying bash configuration changes..."
source ~/.bashrc
echo "✅ Bash configuration applied to current session"

echo "🎉 Tools initialization complete!"
