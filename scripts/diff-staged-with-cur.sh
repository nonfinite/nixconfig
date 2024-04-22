#!/usr/bin/env bash
flake="$( dirname "${BASH_SOURCE[0]}" )/.."
sudo nixos-rebuild build --flake $flake
xargs nix store diff-closures /nix/var/nix/profiles/system ./result
sudo rm ./result
