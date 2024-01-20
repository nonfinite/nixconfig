{ config, inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  # This is required for /var/log in case it doesn't exist in
  # /nix/persist at boot time: https://github.com/nix-community/impermanence/issues/121
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # the limited amount of space on tmpfs can cause problems
  # when unpacking large files to tmp, so instead persist /tmp and clear it on boot
  boot.tmp.cleanOnBoot = true;
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/tmp"
    ];
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  programs.fuse.userAllowOther = true;

  # Ensure all user's home directories exist and have the correct privs
  system.activationScripts.persistent-dirs.text =
    let
      mkHomePersist = user: lib.optionalString user.createHome ''
        mkdir -p /nix/persist/${user.home}
        chown ${user.name}:${user.group} /nix/persist/${user.home}
        chmod ${user.homeMode} /nix/persist/${user.home}
      '';
      users = lib.attrValues config.users.users;
    in
    lib.concatLines (map mkHomePersist users);
}
