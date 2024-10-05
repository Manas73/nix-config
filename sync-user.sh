#!/usr/bin/env bash

# Fix root-owned sqlite errors
sudo chown -R 1000:users ~/.cache/nix;

# Install and build home-manager configuration
home-manager switch --flake .#user --show-trace 2>&1 | tee home-rebuild.log;
