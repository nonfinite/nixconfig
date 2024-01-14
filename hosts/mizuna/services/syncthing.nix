paths@{ config, data }: { config, lib, ... }:
let
  devices = {
    cardamom = {
      id = "TA7W2SP-S4ECH55-EVGZY3N-CLU67CF-VNEL5EY-PIHICGU-R2MMW6K-YCXSUA4";
      name = "cardamom";
    };
    mizuna = {
      id = "IAEFJXY-QJSHL2U-LTSVJLT-X5IDPD7-DCCQ6AA-YVIVVAC-DYUAAUE-ZUKN5AI";
      name = "mizuna";
    };
  };

  folders = {
    pictures-backgrounds = {
      id = "diz2l-1sn3a";
      label = "Pictures/Backgrounds";
      path = "${paths.data}/Pictures/Backgrounds";
      devices = [
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    pictures-saved = {
      id = "4ym4z-n2uwg";
      label = "Pictures/Saved";
      path = "${paths.data}/Pictures/Saved";
      devices = [
        devices.cardamom.name
        devices.mizuna.name
      ];
    };
  };

  foldersForCurrentHost = lib.filterAttrs (n: v: builtins.any (d: config.networking.hostName == d) v.devices) folders;
in
{
  services.syncthing = {
    enable = true;
    configDir = "${paths.config}/syncthing";
    group = "users";
    user = "nonfinite";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = devices;
      folders = builtins.mapAttrs
        (name: folder: {
          inherit (folder) id label path devices;
          enable = true;
        })
        foldersForCurrentHost;
      options = {
        localAnnounceEnabled = true;
        relaysEnabled = false;
        urAccepted = -1;
      };
    };
  };
}
