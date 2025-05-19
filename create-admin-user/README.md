# Create Admin User

A secure bash script to create a sudo-enabled admin user on Linux systems and lock the root account for improved security.

## Features

- Creates a new user with sudo privileges
- Generates a secure random temporary password
- Forces password change on first login
- Locks the root account for password-based authentication
- Verifies the setup by switching to the new user

## Security Benefits

- Eliminates the security risk of shared root credentials
- Follows the principle of least privilege
- Creates audit trail (sudo commands are logged)
- Maintains key-based SSH root access from trusted machines only

## Requirements

- Debian-based Linux distribution (Ubuntu, Debian, etc.)
- Root or sudo access to run the script

## Usage

1. Download the script:
   ```bash
   wget https://raw.githubusercontent.com/your-username/devops-bash-scripts/main/create-admin-user/create-admin-user.sh
