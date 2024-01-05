{ device, inputs, lib, ... }:
let
  crypted_content = {
    type = "btrfs";
    extraArgs = [ "-f" ];
    subvolumes = {
      "/root" = {
        mountpoint = "/";
        mountOptions = [ "compress=zstd" "noatime" ];
      };
      "/persist" = {
        mountpoint = "/nix/persist";
        mountOptions = [ "compress=zstd" "noatime" ];
      };
      "/nix" = {
        mountpoint = "/nix";
        mountOptions = [ "compress=zstd" "noatime" ];
      };
      "/swap" = {
        mountpoint = "/.swapvol";
        swap = {
          swapfile.size = "10G";
        };
      };
    };

    mountpoint = "/.btrfs-root";
    swap = {
      swapfile = {
        size = "10G";
      };
    };
  };
in
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
          # /dev/disk/by-partlabel/disk-main-ESP
          esp = {
            priority = 1;
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
              content = crypted_content;
            };
          };
        };
      };
    };
  };

  # From https://github.com/nix-community/impermanence
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount ${device} /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
