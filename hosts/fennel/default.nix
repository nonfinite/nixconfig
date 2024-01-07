args@{ inputs, lib, pkgs, ... }:
let
  pk = import ../../pub-keys.nix;
  diskConfig = {
    device = "/dev/disk/by-id/wwn-0x5f8db4c23440026d";
    tmpfsSize = "2G";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ./zfs.nix

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig))

    (import ../common/boot/network-luks-unlock.nix { networkKernelModule = "igb"; })
    ../common/global
    ../common/monit.nix
    # ../common/secrets
    ../common/users/nonfinite
    ../common/virtualization/podman.nix
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
      allowSFTP = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    sshfs
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      pk.users.nonfinite
    ];
  };

  system.stateVersion = "23.11";
}
