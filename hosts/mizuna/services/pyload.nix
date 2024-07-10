{ mizuna, ... }:
{
  virtualisation.oci-containers.containers.pyload = {
    image = "lscr.io/linuxserver/pyload-ng";
    hostname = "pyload-ng";
    extraOptions = [ ];
    environment = {
      "PUID" = mizuna.defaultUser;
      "PGID" = mizuna.defaultGroup;
      "TZ" = "Etc/UTC";
    };
    ports = [
      "${mizuna.ports.str.pyload}:8000"
    ];
    volumes = [
      "/enc/temp/pyload/config:/config"
      "/enc/temp/pyload/downloads:/downloads"
    ];
  };
}
