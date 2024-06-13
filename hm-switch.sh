#!/usr/bin/env bash
flake="$( dirname "${BASH_SOURCE[0]}" )"
home-manager switch --flake $flake
