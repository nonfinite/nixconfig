{ config, mizuna, ... }:
let
  storage = "/enc/containers/home-assistant";
in
{
  virtualisation.oci-containers.containers = {
    home-assistant = {
      image = "ghcr.io/home-assistant/home-assistant:stable";
      hostname = "home-assistant";
      user = mizuna.defaultUserGroup;
      extraOptions = [
        "--network=host"
      ];
      ports = [
        "${mizuna.ports.str.home-assistant}:8123"
      ];
      volumes = [
        "${storage}/config:/config"
        "/etc/localtime:/etc/localtime:ro"
        "/run/dbus:/run/dbus:ro"
      ];
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [{
      settings.allow_anonymous = false;
      users = {
        hass = {
          hashedPassword = "$7$101$Vh1mNv58vYlhEWib$ojxlkMVt7QWvaebjfVpw7g3feXl7t9nCzbQiAt70h7UbG4FF/SO59nlLEv+O4CgCsAVSuo0xyKJ3bkEHZB/1zw==";
        };
        iot = {
          hashedPassword = "$7$101$tksx+1SxRAAiNIIq$ZWR9lAWVese2bNy26W07NxoiK06NJn/aHF+0Vv5O1U0rw8O43YZzuUczhXyYj2f3wRY2XQbRB95iddw9h5Po0Q==";
        };
      };
    }];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1883 ];
  };

  environment.persistence."/nix/persist" = {
    directories = [
      config.services.mosquitto.dataDir
    ];
  };
}
