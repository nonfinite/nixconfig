#!/usr/bin/env bash
flake="$( dirname "${BASH_SOURCE[0]}" )"
sudo nixos-rebuild build --flake $flake
