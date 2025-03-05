#!/bin/bash

# Update the package repositories
sudo dnf update -y

# Install Podman and its dependencies
sudo dnf install podman -y

# (Optional) Install Buildah, Skopeo, and other related tools if needed
# sudo dnf install buildah skopeo -y

# Verify the Podman installation
podman --version

echo "Podman installation complete."

# Optional: Enable rootless Podman (recommended for security)
# This allows you to run containers as a non-root user.
# The following steps are needed if you want to run rootless podman.

# 1. log out and log back in, or run the following command to load the changes to your user.
newgrp systemd-journal

# 2. Test to see if rootless podman works.
podman run hello-world
#If you get an error relating to cgroups v2, you might need to enable it.
#Instructions for that follow.

# Optional: Enable cgroups v2 if needed (if you encounter cgroup errors)
# This is usually the default on newer RHEL systems, but it's worth checking.
# If you are using a virtual machine, you will need to make sure that the hypervisor is configured correctly for cgroups v2.
# You will also need to reboot your system.

# Check cgroup version:
# cat /proc/self/mountinfo | grep cgroup2

# If you see cgroup2, then cgroups v2 is enabled.
# If you see cgroup, then cgroups v1 is enabled.
# If you need to switch to cgroups v2, the following steps are needed.
# grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=1"
# reboot

# After rebooting, re-run the check to confirm cgroups v2 is enabled.

# Optional: Enable automatic updates of Podman
# sudo dnf install dnf-automatic -y
# sudo systemctl enable --now dnf-automatic.timer
# sudo systemctl edit dnf-automatic.timer #Then edit the configuration file to include podman in the upgrade_type=security or upgrade_type=all