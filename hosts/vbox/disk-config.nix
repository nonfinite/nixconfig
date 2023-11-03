{ device, lib, ... }:
{
  disko.devices = {
    disk.main = {
      device = lib.mkDefault device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # /dev/disk/by-partlabel/disk-main-boot
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          # /dev/disk/by-partlabel/disk-main-ESP
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          # /dev/disk/by-partlabel/disk-main-root
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraOpenArgs = [ "--allow-discards" ];
              askPassword = true;
              initrdUnlock = true;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "defaults"
                ];
              };
            };
          };
        };
      };
    };
  };
}
