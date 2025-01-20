#!/bin/bash

# Function to display the growing dots animation
growing_dots() {
  local delay=0.5
  local dots=( 'running.  ' 'running.. ' 'running...' 'running.. ' 'running.  ' 'running   ' )
  while true; do
    for dot in "${dots[@]}"; do
      printf "\r%s" "$dot"
      sleep $delay
    done
  done
}

# Function to run the Internet speed test
run_speedtest() {
  printf "\nInternetSpeed test\n"
  speedtest-cli --simple
}

# Display key options
printf "\e[1;34mPress 1 to start the Internet speed test\e[0m\n"
printf "\e[1;34mPress any other key to exit\e[0m\n"

# Main loop to handle key presses
while true; do
  read -n 1 -s key
  case $key in
    1)
      printf "\e[1;32mStarting Internet speed test...\e[0m\n"
      growing_dots &
      animation_pid=$!
      run_speedtest
      kill $animation_pid
      printf "\n\e[1;32mInternet speed test completed.\e[0m\n"
      ;;
    *)
      printf "\e[1;33mExiting...\e[0m\n"
      exit 0
      ;;
  esac
done