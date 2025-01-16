#!/bin/bash

[ "$(whoami)" == "root" ] || { echo "raspi-bento requires to be run as sudo!"; exit 1; }

# Check for required packages
REQUIRED_PACKAGES=("hdparm" "sysbench" "speedtest-cli")
for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg -l | grep -q "$pkg"; then
        echo "Package $pkg is not installed."
    else
        echo "Package $pkg is installed."
    fi
done