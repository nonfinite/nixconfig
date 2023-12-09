args@{ inputs, lib, pkgs, ... }:
let
  diskConfig = {
    device = "/dev/disk/by-id/usb-Samsung_PSSD_T7_S5T3NJ0N902439F-0:0";
    tmpfsSize = "2G";
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
    hostName = "fennel";
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

  system.stateVersion = "23.11";
}
