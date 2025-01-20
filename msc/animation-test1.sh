#!/bin/bash

# Function to display the growing dots animation
growing_dots() {
  local delay=0.5
  local dots=( '.  ' '.. ' '...' '.. ' '.  ' '   ' )
  while true; do
    for dot in "${dots[@]}"; do
      printf "\r%s" "$dot"
      sleep $delay
    done
  done
}

# Function to run the Internet speed test
run_speedtest() {
  echo -e "\nRunning InternetSpeed test..."
  speedtest-cli --simple
}

# Display key options
echo -e "\e[1;34mPress 1 to start the Internet speed test\e[0m"
echo -e "\e[1;34mPress any other key to exit\e[0m"

# Main loop to handle key presses
while true; do
  read -n 1 -s key
  case $key in
    1)
      echo -e "\e[1;32mStarting Internet speed test...\e[0m"
      growing_dots &
      animation_pid=$!
      run_speedtest
      kill $animation_pid
      echo -e "\n\e[1;32mInternet speed test completed.\e[0m"
      ;;
    *)
      echo -e "\e[1;33mExiting...\e[0m"
      exit 0
      ;;
  esac
done