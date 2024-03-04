{ mizuna, ... }:
let
  storage = "/enc/containers/transmission";
  extraOptions = [ "--network=container:gluetun" ];
in
{
  virtualisation.oci-containers.containers.transmission = {
    image = "lscr.io/linuxserver/transmission:latest";
    # hostname is incompatible with network=container
    # hostname = "transmission";
    # user = mizuna.defaultUserGroup;
    extraOptions = extraOptions;
    environment = {
      PUID = mizuna.defaultUser;
      PGID = mizuna.defaultGroup;
      TZ = "Etc/UTC";
    };
    volumes = [
      "${storage}/config:/config"
      "/enc/temp/transmission:/downloads"
    ];
  };
}
