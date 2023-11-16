{ config, ... }:
{
  networking.wireless = {
    enable = true;
    environmentFile = config.age.secrets.wifi-environment.path;
    networks = {
      Lavenir = {
        psk = "@LavenirPass@";
      };
    };
  };
}
