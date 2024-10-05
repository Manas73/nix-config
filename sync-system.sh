#!/usr/bin/env bash

sudo nixos-rebuild switch --flake .#system --show-trace;