#!/bin/bash

# Determine the OS type
os_type=$(uname)

# Get model information
if [ "$os_type" == "Linux" ]; then
    model_info=$(cat /proc/device-tree/model 2>/dev/null | tr -d '\0' || echo "Unknown Model")
elif [ "$os_type" == "Darwin" ]; then
    model_info=$(sysctl -n hw.model)
else
    model_info="Unknown Model"
fi

# Get OS information
if [ "$os_type" == "Linux" ]; then
    os_info=$(lsb_release -d | awk -F: '{print $2}' | xargs)
elif [ "$os_type" == "Darwin" ]; then
    os_info=$(sw_vers -productName)" "$(sw_vers -productVersion)
else
    os_info="Unknown OS"
fi

# Get hostname
hostname=$(hostname)

# Get architecture
arch=$(uname -m)

# Get current date and time
datetime=$(date +"%Y-%m-%d - %H:%M")

# Output the information
echo "Model: $model_info"
echo "OS: $os_info"
echo "Hostname: $hostname"
echo "Architecture: $arch"
echo "Date and Time: $datetime"
