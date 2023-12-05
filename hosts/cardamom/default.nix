args@{ inputs, lib, pkgs, ... }:
let
  device = "/dev/disk/by-id/usb-Samsung_PSSD_T7_S5T3NJ0N902439F-0:0";
in
{
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix

    inputs.disko.nixosModules.disko
    (import ../../disko/btrfs.nix device)

    ../common/users/nonfinite.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    glxinfo
  ];

  hardware = {
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
    };
  };

  networking = {
    hostName = "cardamom";
    useDHCP = lib.mkDefault true;
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh.enable = true;
  };
}
