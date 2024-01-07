{ pkgs, ... }:
let
  zfs-init = pkgs.writeTextFile {
    name = "zfs-init";
    destination = "/bin/zfs-init";
    executable = true;
    text = ''
      #!/usr/bin/env bash
      mkdir -p /etc/exports.d/

      if [[ ! $(zpool list -Ho name | grep tank) ]]; then
        zpool import tank
      fi

      if [[ ! $(zfs list -Ho name | grep tank/enc) ]]; then
        zfs load-key tank/enc
      fi

      zfs mount -a
    '';
  };
in
{
  # zfs create -o mountpoint=/enc/ tank/enc
  imports = [
    ../common/zfs.nix
  ];

  environment.systemPackages = [
    zfs-init
  ];
}
