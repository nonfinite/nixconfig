sudo nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake .#$1 root@localhost
