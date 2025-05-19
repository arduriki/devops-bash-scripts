#!/bin/bash

# Check if a username was provided
if [ $# -eq 0 ]; then
    echo "Error: No username provided"
    echo "Usage: $0 username"
    exit 1
fi

# Store the provided username in a variable
USERNAME=$1

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 
   exit 1
fi

# Non-interactive user creation with the provided username
adduser --disabled-password --gecos "" "$USERNAME"

# Set a temporary random password
TEMP_PASSWORD=$(openssl rand -base64 12)
echo "$USERNAME:$TEMP_PASSWORD" | chpasswd

# Add user to admin/sudo group
usermod -aG sudo "$USERNAME"

# Force password change on first login
passwd -e "$USERNAME"

# Lock the root account password (prevents password login but allows SSH key access)
passwd -l root
echo "Root account has been locked for password authentication."
echo "Note: SSH key-based authentication for root is still possible from authorized machines."

echo "Admin user '$USERNAME' has been created successfully."
echo "Temporary password: $TEMP_PASSWORD"
echo "User will be required to change password on first login."

# Print a clear separator
echo "--------------------------------------------------------------"
echo "Switching to user '$USERNAME' now. Enter the temporary password when prompted."
echo "You will be required to set a new password immediately."
echo "--------------------------------------------------------------"

# Switch to the new user
su - "$USERNAME"

# Note: Any code after this point won't execute until the user exits their session
echo "Back to the original session. User setup and verification complete."
