# Deploying

From a NixOS live system run: 

1. Set password for root: `sudo passwd`
2. Install nix command: `nix-shell -p nix`
3. Install via nixos-anywhere: `sudo nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake github:nonfinite/nixconfig#<HOST> root@localhost`

Remember to test with `--vm-test` as part of the nix run command.

# Bootstrap from Live CD

1. Boot NixOS live CD, then on the live cd:
   * `sudo su`
   * `mkdir ~/.ssh`
   * `curl https://github.com/nonfinite.keys > ~/.ssh/authorized_keys`
2. From the host machine, install via nixos-anywhere:
   `nix run github:nix-community/nixos-anywhere -- --flake github:nonfinite/nixconfig#<HOST> root@<HOST-IP>`

