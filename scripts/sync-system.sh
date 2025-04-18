#!/usr/bin/env bash

# Source the common library
source "$(dirname "$0")/lib.sh"

print_msg "green" "==== Starting system configuration sync ===="

# Auto-detect system type and hostname
hostname=$(get_hostname)

if is_nixos; then
  apply_nixos_config "$hostname"
elif is_darwin; then
  apply_darwin_config "$hostname"
else
  print_msg "red" "Unsupported system type! Cannot determine if NixOS or Darwin."
  exit 1
fi

print_msg "green" "==== System configuration sync completed! ===="