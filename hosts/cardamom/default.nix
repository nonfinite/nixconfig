args@{ lib, pkgs, ... }:
let
  diskConfig = {
    device = "/dev/disk/by-uuid/13d43151-c652-44ef-8601-f0a4924c7f21";
    tmpfsSize = "4G";
  };
in
{
  imports = [
    ./hardware-configuration.nix

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig))

    ../common/global
    ../common/users/nonfinite
    (import ../common/users/autologin.nix "nonfinite")

    ../common/desktop/gnome
    ../common/games
    ../common/hardware/fingerprint.nix
  ];

  networking = {
    hostName = "cardamom";
    useDHCP = lib.mkDefault true;
  };

  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    git
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
    ];
  };

  system.stateVersion = "23.05";
}
