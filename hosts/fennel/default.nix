args@{ inputs, lib, pkgs, ... }:
let
  diskConfig = {
    device = "/dev/disk/by-id/usb-Samsung_PSSD_T7_S5T3NJ0N902439F-0:0";
    tmpfsSize = "2G";
    keyFile = "/dev/disk/by-id/usb-USB_SanDisk_3.2Gen1_0501ae4193cfcc64f123d6180fa2025681512c89072972a58f03f0eaf8059da91385000000000000000000008b621e7a00081210835581075f2c8bb3-0:0";
  };
in
{
  imports = [
    ./hardware-configuration.nix

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig))

    ../common/global
    ../common/secrets
    ../common/zfs.nix
    ../common/virtualization/docker.nix
  ];

  networking = {
    hostName = "fennel-dev";
    useDHCP = lib.mkDefault true;
  };

  security.sudo.wheelNeedsPassword = false;
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    git
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1FEtYVAP1ZxuvBuW+OvvTyYztsVuHwAQw3Va4jDqtt"
    ];
  };

  swapDevices = [
    {
      device = "/nix/persist/swapfile";
      size = 102410;
    }
  ];

  system.stateVersion = "23.11";
}
