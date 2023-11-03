args@{ modulesPath, pkgs, ... }:
let
  device = "/dev/sda";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix

    (import ../common/disk-configs/impermanent (args // { device = device; }))

    ../common/global
    ../common/users/nonfinite
    (import ../common/users/autologin.nix (args // { user = "nonfinite"; }))
  ];

  networking = {
    hostName = "vbox";
    useDHCP = true;
  };

  security.sudo.wheelNeedsPassword = false;

  boot.loader.grub = {
    device = device;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
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
