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

      };
      folders = {

      };
      options = {
        localAnnounceEnabled = true;
        relaysEnabled = false;
        urAccepted = -1;
      };
    };
  };
}