{ config, inputs, lib, pkgs, outputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../features/cli
    ./git.nix
  ];

  systemd.user.startServices = "sd-switch";

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  programs = {
    home-manager.enable = true;
  };

  services = {
    ssh-agent.enable = true;
  };

  home = {
    stateVersion = lib.mkDefault "23.05";

    username = lib.mkDefault "nonfinite";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = [ "$HOME/.local/bin" ];

    file.".config/electron-flags.conf".source = ../.config/electron-flags.conf;
    file.".config/pnpm/rc".text = "store-dir=/home/nonfinite/.pnpm-store";

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

        ".cargo"
        ".pnpm-store"
        ".ssh"
      ];
    };

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    shellAliases = {
      ll = "ls -la";
      cls = "clear";

      nd = "nix develop";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";

      pw-gen = "tr -dc A-Za-z0-9 </dev/urandom | head -c";
      pod-ps = "podman ps --format \"table {{.Image}}\\t{{.Ports}}\\t{{.Status}}\\t{{.Names}}\"";
    };
  };
}
