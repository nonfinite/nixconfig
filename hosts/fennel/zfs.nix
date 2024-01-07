{
  imports = [
    ../common/zfs.nix
  ];

  fileSystems."/enc" = {
    device = "tank/enc";
    fsType = "zfs";
  };
}
