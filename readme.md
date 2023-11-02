# Deploying

From a NixOS live system run: 

```
nix-shell -p nix
nix run github:nix-community/nixos-anywhere -- --flake github:nonfinite/nixconfig#HOST
```
