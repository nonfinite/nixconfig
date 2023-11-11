args@{ lib, pkgs, ... }:
let
  diskConfig = {
    device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL21T0HCLR-00BL7_S64PNX0TA24210";
    tmpfsSize = "4G";
  };
in
{
  imports = [
    ./hardware-configuration.nix

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig // { fontSize = 36; }))

    ../common/global
    ../common/users/nonfinite
    (import ../common/users/autologin.nix "nonfinite")

    ../common/desktop/hyprland
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
