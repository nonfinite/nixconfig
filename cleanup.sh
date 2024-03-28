#!/usr/bin/env bash
sudo nix-collect-garbage --delete-older-than 7d 
nix-collect-garbage --delete-older-than 7d
