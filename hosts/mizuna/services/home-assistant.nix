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

    ha-ps5-mqtt = {
      image = "ghcr.io/funkeyflo/ps5-mqtt/amd64:latest";
      hostname = "ha-ps5-mqtt";
      user = mizuna.defaultUserGroup;
      extraOptions = [
        "--network=host"
      ];
      entrypoint = "/config/run.sh";
      environmentFiles = [ "${storage}/ps5-mqtt/.env" ];
      environment = {
        MQTT_HOST = "localhost";
        MQTT_PORT = "1883";
        DEVICE_CHECK_INTERVAL = "5000";
        DEVICE_DISCOVERY_INTERVAL = "60000";
        ACCOUNT_CHECK_INTERVAL = "5000";
        INCLUDE_PS4_DEVICES = "false";
        FRONTEND_PORT = mizuna.ports.str.home-assistant-ps5;
        CREDENTIAL_STORAGE_PATH = "/config/credentials.json";
        DEBUG = "*";
        DEVICE_DISCOVERY_BROADCAST_ADDRESS = "192.168.122.44";
        # CONFIG_PATH = "/config/options.json";
      };
      volumes = [
        "${storage}/ps5-mqtt:/config"
      ];
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [{
      settings.allow_anonymous = false;
      users = {
        hass = {
          acl = [ "readwrite #" ];
          hashedPassword = "$7$101$Vh1mNv58vYlhEWib$ojxlkMVt7QWvaebjfVpw7g3feXl7t9nCzbQiAt70h7UbG4FF/SO59nlLEv+O4CgCsAVSuo0xyKJ3bkEHZB/1zw==";
        };
        iot = {
          acl = [ "readwrite #" ];
          hashedPassword = "$7$101$tksx+1SxRAAiNIIq$ZWR9lAWVese2bNy26W07NxoiK06NJn/aHF+0Vv5O1U0rw8O43YZzuUczhXyYj2f3wRY2XQbRB95iddw9h5Po0Q==";
        };
        ps5 = {
          acl = [ "readwrite #" ];
          hashedPassword = "$7$101$Yp9gi3JS+qPzNxWR$hOCLhs+TQYMsQeagvJI3KR5XaRMWIgsrUPWHle2UqNk8kluDIC1yQZFYMezNaNUdrMBg3xfEm/sro8BQGvqO0g==";
        };
      };
    }];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1883 mizuna.ports.home-assistant-ps5 ];
  };

  environment.persistence."/nix/persist" = {
    directories = [
      config.services.mosquitto.dataDir
    ];
  };
}
