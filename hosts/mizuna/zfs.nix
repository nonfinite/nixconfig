{ ... }:
{
  # zfs create -o mountpoint=/enc/ tank/enc
  imports = [
    ../common/zfs.nix
  ];

  boot.zfs.extraPools = [ "tank" ];

  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "daily";
    };
    autoSnapshot = {
      # to enable this for a dataset: zfs set com.sun:auto-snapshot=true DATASET
      enable = true;
      flags = "-k -p --utc";
    };
  };
}
