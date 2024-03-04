args@{ lib, pkgs, globals, ... }:
let
  pk = globals.pubKeys;
  diskConfig = {
    device = "/dev/disk/by-id/wwn-0x5f8db4c23440026d";
    tmpfsSize = "2G";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ./services
    ./zfs.nix

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig))

    (import ../common/boot/network-luks-unlock.nix { networkKernelModule = "igb"; inherit globals; })
    ../common/global
    ../common/monit.nix
    # ../common/secrets
    ../common/users/nonfinite
    ../common/virtualization/docker.nix
  ];

  networking = {
    hostName = "mizuna";
    domain = "mizuna.dev";
    hostId = "fcc06b17";
    useDHCP = lib.mkDefault true;
  };

  services.ddclient = {
    enable = true;
    configFile = "/enc/containers/ddclient/ddclient.conf";
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
    tmux
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      pk.users.nonfinite
    ];
  };

  swapDevices = [{
    device = "/nix/swapfile";
    size = 16 * 1024;
  }];

  system.stateVersion = "23.11";
}
