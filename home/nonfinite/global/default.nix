{ config, inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home = {
    username = lib.mkDefault "nonfinite";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";

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
  };
}
