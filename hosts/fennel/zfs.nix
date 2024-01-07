{ pkgs, ... }:
let
  zfs-init = pkgs.writeTextFile {
    name = "zfs-init";
    destination = "/bin/zfs-init";
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if [[ $UID != 0 ]]; then
        echo "Please run this script with sudo:"
        echo "sudo $0 $*"
        exit 1
      fi

      mkdir -p /etc/exports.d/

      if [[ ! $(zpool list -Ho name | grep tank) ]]; then
        echo "Importing tank..."
        zpool import tank
      fi

      if [[ ! $(zfs list -Ho name | grep tank/enc) ]]; then
        echo "Loading keys..."
        zfs load-key tank/enc
      fi

      echo "Mounting..."
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
