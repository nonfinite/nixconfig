{ config, lib, pkgs, ... }:
{
  imports = [ ];

  systemd.user.startServices = "sd-switch";

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = lib.mkDefault "23.05";

    username = lib.mkDefault "nonfinite";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };
}
