rec {
  devices = {
    cardamom = {
      id = "TA7W2SP-S4ECH55-EVGZY3N-CLU67CF-VNEL5EY-PIHICGU-R2MMW6K-YCXSUA4";
      name = "cardamom";
    };
    mizuna = {
      id = "IAEFJXY-QJSHL2U-LTSVJLT-X5IDPD7-DCCQ6AA-YVIVVAC-DYUAAUE-ZUKN5AI";
      name = "mizuna";
      rootDir = "/enc/data";
    };
  };

  folders = {
    pictures-saved = {
      id = "4ym4z-n2uwg";
      label = "pictures/saved";
      path = "pictures/saved";
      devices = [
        devices.cardamom.name
        devices.mizuna.name
      ];
    };
  };
}
