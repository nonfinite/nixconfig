{ device, inputs, lib, tmpfsSize ? "2G", keyFile ? null, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./persistence.nix
  ];

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
              askPassword = keyFile == null;
              initrdUnlock = true;
              settings = {
                keyFile = keyFile;
              };
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
                mountOptions = [
                  "defaults"
                ];
              };
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=${tmpfsSize}"
        "defaults"
        "mode=755"
      ];
    };
  };
}
