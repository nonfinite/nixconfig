{
  networking.wireless = {
    enable = true;
    environmentFile = "/persist/secrets/wifi.env";
    networks = {
      Lavenir = {
        psk = "@LavenirPass@";
      };
    };
  };
}
