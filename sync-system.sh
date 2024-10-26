#!/usr/bin/env bash

sudo nixos-rebuild switch --flake .#alfred --show-trace 2>&1 | tee home-rebuild.log;