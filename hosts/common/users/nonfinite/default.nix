{ config, pkgs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    ./1password.nix
  ];

  users = {
    mutableUsers = false;
    users.nonfinite = {
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ ifTheyExist [ "networkmanager" "vboxsf" "video" ];
      hashedPassword = "$y$jFT$0XD3a2cK1381FJl84/Qql0$XHJbaaJurbFHApb3ocubn5a9HMv/xAxD5lic8k38RM.";
      packages = [ pkgs.home-manager ];
    };
  };

  home-manager.users.nonfinite = import ../../../../home/nonfinite/${config.networking.hostName}.nix;
}