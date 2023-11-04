{ config, inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home = {
    stateVersion = lib.mkDefault "23.05";

    username = lib.mkDefault "nonfinite";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

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
    };
  };
}
