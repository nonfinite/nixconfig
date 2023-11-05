args@{ lib, modulesPath, pkgs, ... }:
let
  diskConfig = {
    device = "/dev/disk/by-id/ata-VBOX_HARDDISK_VB08f0cfa3-752ef4ec";
  };
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig))

    ../common/global
    ../common/users/nonfinite
    (import ../common/users/autologin.nix "nonfinite")
  ];

  networking = {
    hostName = "vbox";
    useDHCP = lib.mkDefault true;
  };

  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
    ];
  };

  system.stateVersion = "23.05";
}
