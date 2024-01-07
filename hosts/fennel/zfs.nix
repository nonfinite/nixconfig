{ pkgs, ... }:
{
  # zfs create -o mountpoint=/enc/ tank/enc
  imports = [
    ../common/zfs.nix
  ];

  boot.zfs.extraPools = [ "tank" ];
}
