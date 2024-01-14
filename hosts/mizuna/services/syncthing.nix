{ globals, ... }:
let
  data = "/enc/data";
in
{
  services.syncthing = {
    enable = true;
    configDir = "/enc/containers/syncthing";
    group = "users";
    user = "nonfinite";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        cardamom = globals.syncthing.devices.cardamom;
        mizuna = globals.syncthing.devices.mizuna;
      };
      folders = with globals.syncthing.folders; {
        pictures-saved = with pictures-saved; {
          inherit id label devices;
          enable = true;
          path = "${data}/${path}";
        };
      };
      options = {
        localAnnounceEnabled = true;
        relaysEnabled = false;
        urAccepted = -1;
      };
    };
  };
}
