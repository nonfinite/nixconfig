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
  };

  services.sanoid = {
    enable = true;
    interval = "*-*-* *:05:00";
    extraArgs = [ "--verbose" ];
    datasets."tank/enc" = {
      recursive = true;
      autoprune = true;
      autosnap = true;
      hourly = 36;
      daily = 30;
      monthly = 3;
      yearly = 0;
    };
    datasets."tank/enc/temp" = {
      recursive = true;
      autoprune = true;
      autosnap = false;
      hourly = 0;
      daily = 0;
      monthly = 0;
      yearly = 0;
    };
  };

  services.syncoid = { };
}
