{ config, inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [ ];
    files = [ ];
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
