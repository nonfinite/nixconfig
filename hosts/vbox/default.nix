args@{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    (import ./disk-config.nix (args // { device = "/dev/sda"; }))
    ../common/users/nonfinite
    (import ../common/users/autologin.nix (args // { user = "nonfinite"; }))
  ];

  networking.hostName = "vbox";
  security.sudo.wheelNeedsPassword = false;

  boot.loader.grub = {
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
