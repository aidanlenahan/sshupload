#!/bin/bash

# Function to check if the current user is root
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    sudo su
  fi
}

# Function to update and upgrade the system
update_system() {
  apt update -y && apt upgrade -y
}

# Function to install minimal necessary packages
install_minimal_packages() {
  apt install -y unattended-upgrades clang gcc ufw
}

# Function to install maximum necessary packages
install_maximum_packages() {
  apt install -y nala cowsay git unattended-upgrades clang gcc python3 python3-dev ufw curl wget snapd tmux neofetch
}

# Function to configure unattended upgrades
configure_unattended_upgrades() {
  dpkg-reconfigure --priority=low unattended-upgrades
}

# Function to setup UFW firewall
setup_firewall() {
  ufw default deny incoming
  ufw default allow outgoing
  ufw allow ssh
  ufw enable
}

# Function to enhance system security
enhance_security() {
  apt install -y fail2ban
  systemctl enable fail2ban
  systemctl start fail2ban

  apt install -y apt-listbugs apt-listchanges
  apt install -y auditd
  systemctl enable auditd
  systemctl start auditd
}

# Function to prompt user for setup type
prompt_setup_type() {
  echo "Do you want a minimal setup or maximum setup of software? (minimal/maximum)"
  read setup_type
}

# Main function to run all setup steps
main() {
  check_root
  update_system
  prompt_setup_type

  if [ "$setup_type" = "minimal" ]; then
    install_minimal_packages
  elif [ "$setup_type" = "maximum" ]; then
    install_maximum_packages
  else
    echo "Invalid choice. Please run the script again and choose either 'minimal' or 'maximum'."
    exit 1
  fi

  configure_unattended_upgrades
  setup_firewall
  enhance_security

  echo "System initialization complete!"
}

# Run the main function
main
