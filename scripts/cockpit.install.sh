#!/bin/bash

# Update package repositories
sudo dnf update -y

# Install Cockpit and its dependencies
sudo dnf install cockpit cockpit-system cockpit-storaged cockpit-networkmanager cockpit-machines -y

# Enable and start the Cockpit service
sudo systemctl enable --now cockpit.socket

# Open the Cockpit port in the firewall (if firewalld is enabled)
if systemctl is-active firewalld >/dev/null 2>&1; then
  sudo firewall-cmd --add-service=cockpit --permanent
  sudo firewall-cmd --reload
  echo "Firewall rules updated."
else
  echo "Firewalld is not active. Ensure port 9090 is open if needed."
fi

# Inform the user of the installation and access instructions.
echo "Cockpit installation complete."
echo "You can access Cockpit by opening a web browser and navigating to:"
echo "https://<your_server_ip_or_hostname>:9090"
echo "Log in with your system username and password."