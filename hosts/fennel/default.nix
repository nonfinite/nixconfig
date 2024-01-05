args@{ inputs, lib, pkgs, ... }:
let
  pk = ../../pub-keys.nix;
  diskConfig = {
    device = "/dev/sda";
  };
in
{
  imports = [
    ./hardware-configuration.nix

    (import ../common/disk-configs/impermanent/btrfs.nix (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig))

    (import ../common/boot/network-luks-unlock.nix { networkKernelModule = ""; })
    ../common/global
    ../common/zfs.nix
    ../common/virtualization/docker.nix
  ];

  networking = {
    hostName = "fennel-dev";
    hostId = "fcc06b17";
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
      pk.users.nonfinite
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
