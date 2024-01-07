{ config, ... }:
{
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;

  # networking.hostId must be set, generate a unique value with:
  # head -c4 /dev/urandom | od -A none -t x4

  environment.shellAliases = {
    "zfs-info" = "zfs list -o name,used,avail,refer,compressratio,encryptionroot,mountpoint,compression -s name";
  };
}
