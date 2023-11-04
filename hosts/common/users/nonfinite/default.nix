{ config, pkgs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;
    users.nonfinite = {
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ ifTheyExist [ "networkmanager" "vboxsf" ];
      hashedPassword = "$y$jFT$Lcu/HJfbqNAZwh3hSJjZn.$tXbVgaKhg8fOKPvTDlGuDxfmZnRazn9m/q9cz7FNdID";
      packages = [ pkgs.home-manager ];
    };
  };

  home-manager.users.nonfinite = import ../../../../home/nonfinite/${config.networking.hostName}.nix;
}
