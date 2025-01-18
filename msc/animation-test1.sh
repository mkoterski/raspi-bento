#!/bin/bash

# Function to display the loading animation
loading_animation() {
  local pid=$!
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Function to start the animation
start_animation() {
  while true; do
    loading_animation &
    wait $!
  done
}

# Display key options
echo -e "\e[1;34mPress 1 to start the animation\e[0m"
echo -e "\e[1;34mPress 2 to stop the animation\e[0m"
echo -e "\e[1;34mPress any other key to exit\e[0m"

# Main loop to handle key presses
while true; do
  read -n 1 -s key
  case $key in
    1)
      echo -e "\e[1;32mStarting animation...\e[0m"
      start_animation &
      animation_pid=$!
      ;;
    2)
      if [ -n "$animation_pid" ]; then
        echo -e "\e[1;31mStopping animation...\e[0m"
        kill $animation_pid
        unset animation_pid
      fi
      ;;
    *)
      echo -e "\e[1;33mExiting...\e[0m"
      if [ -n "$animation_pid" ]; then
        kill $animation_pid
      fi
      exit 0
      ;;
  esac
done