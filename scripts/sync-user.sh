#!/usr/bin/env bash

# Source the common library
source "$(dirname "$0")/lib.sh"

# Get current user
username=$(whoami)

print_msg "green" "==== Starting home-manager configuration sync for $username ===="
apply_home_config "$username"

print_msg "green" "==== Home-manager configuration sync completed! ===="
