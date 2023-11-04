{ config, inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../features/cli
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    stateVersion = lib.mkDefault "23.05";

    username = lib.mkDefault "nonfinite";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = [ "$HOME/.local/bin" ];

    persistence."/nix/persist/home/nonfinite" = {
      allowOther = true;
      directories = [
        "Code"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "VirtualBox VMs"
      ];
    };

    shellAliases = {
      ll = "ls -la";
      cls = "clear";

      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";
    };
  };
}
