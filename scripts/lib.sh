#!/usr/bin/env bash

# Common script functions

# Print a colorful message
print_msg() {
  local color="$1"
  local message="$2"
  
  case "$color" in
    "red") echo -e "\033[0;31m$message\033[0m" ;;
    "green") echo -e "\033[0;32m$message\033[0m" ;;
    "yellow") echo -e "\033[0;33m$message\033[0m" ;;
    "blue") echo -e "\033[0;34m$message\033[0m" ;;
    *) echo "$message" ;;
  esac
}

# Get the hostname of the current system
get_hostname() {
  hostname=$(hostname)
  echo "$hostname"
}

# Check if we're on a NixOS system
is_nixos() {
  if [ -f /etc/nixos/configuration.nix ]; then
    return 0  # true
  else
    return 1  # false
  fi
}

# Check if we're on a Darwin system
is_darwin() {
  if [[ "$(uname)" == "Darwin" ]]; then
    return 0  # true
  else
    return 1  # false
  fi
}

# Apply NixOS configuration
apply_nixos_config() {
  local hostname="$1"
  print_msg "blue" "Applying NixOS configuration for $hostname..."
  sudo nixos-rebuild switch --flake ".#$hostname"
}

# Apply Darwin configuration
apply_darwin_config() {
  local hostname="$1"
  print_msg "blue" "Applying Darwin configuration for $hostname..."
  darwin-rebuild switch --flake ".#$hostname"
}

# Apply Home Manager configuration
apply_home_config() {
  local username="$1"
  print_msg "blue" "Applying Home Manager configuration for $username..."
  home-manager switch --flake ".#$username"
} 