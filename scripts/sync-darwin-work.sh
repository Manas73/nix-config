#!/usr/bin/env bash

# Source the common library
source "$(dirname "$0")/lib.sh"

print_msg "green" "==== Starting Darwin configuration sync ===="
apply_darwin_config "manass-KY4RYYHFF6"

print_msg "green" "==== Starting home-manager configuration sync ===="
apply_home_config "manas.s"

print_msg "green" "==== Configuration sync completed successfully! ===="