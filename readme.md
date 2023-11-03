# Deploying

From a NixOS live system run: 

```
nix-shell -p nix
nix run github:nix-community/nixos-anywhere -- --flake github:nonfinite/nixconfig#HOST
```

Remember to test with `--vm-test` as part of the nix run command.
