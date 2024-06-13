paths@{ config, data }: { config, lib, ... }:
let
  st = import ../../globals/syncthing.nix lib;
  devices = st.devices;
  folders = st.foldersFor paths;
  foldersForCurrentHost = st.foldersForDevice folders config.networking.hostName;
  requiredPaths = [ "/var/tmp" ] ++ builtins.map (f: f.path) (lib.attrValues foldersForCurrentHost);
in
{
  services.syncthing = {
    enable = true;
    configDir = paths.config;
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

  systemd.services.syncthing.unitConfig.RequiresMountsFor = requiredPaths;
}
