#!/usr/bin/env bash

# Source the common library
source "$(dirname "$0")/lib.sh"

print_msg "blue" "Formatting Nix files..."

# Find all .nix files and format them
find . -name "*.nix" -type f | while read -r file; do
  print_msg "yellow" "Formatting $file"
  nixpkgs-fmt "$file"
done

print_msg "green" "Formatting complete!" 