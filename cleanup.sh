#!/usr/bin/env bash
sudo nix-collect-garbage --delete-older-than 7d 
nix-collect-garbage --delete-older-than 7d
echo Note: must run `nixos-rebuild switch` before /boot will get cleaned up
echo If /boot is full, try manually deleting the oldest kernel in /boot/kernels
echo Use "df -h /boot" and "du -hs /boot/*" to check available space