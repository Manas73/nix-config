#!/usr/bin/env bash

# Sync Dawrin Configuration
darwin-rebuild switch --flake .#manass-KY4RYYHFF6 --show-trace 2>&1 | tee home-rebuild.log;
