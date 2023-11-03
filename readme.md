# Deploying

From a NixOS live system run: 

```
nix-shell -p nix
nix run github:nix-community/nixos-anywhere -- --flake github:nonfinite/nixconfig#HOST
```

Remember to test with `--vm-test` as part of the nix run command.

# Bootstrap from Live CD

1. Boot NixOS live CD, then on the live cd:
   * `sudo su`
   * `mkdir ~/.ssh`
   * `curl https://github.com/nonfinite.keys > ~/.ssh/authorized_keys`
2. From the host machine, install via nixos-anywhere:
   `nix run github:nix-community/nixos-anywhere -- --flake github:nonfinite/nixconfig#<HOST> root@<HOST-IP>`

