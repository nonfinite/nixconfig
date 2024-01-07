{ pkgs, ... }:
let
  init-zfs = pkgs.writeTextFile {
    name = "init-zfs";
    destination = "/bin/init-zfs";
    executable = true;
    text = ''
      #!/usr/bin/env bash
      mkdir /etc/exports.d/
      zpool import tank && \
      zfs load-key tank/enc && \
      zfs mount -a
    '';
  };
in
{
  imports = [
    ../common/zfs.nix
  ];

  environment.systemPackages = [
    init-zfs
  ];
}
