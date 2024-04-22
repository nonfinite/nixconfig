#!/usr/bin/env bash
ls -d /nix/var/nix/profiles/system-*-link | tail -n 2 | xargs nix store diff-closures
