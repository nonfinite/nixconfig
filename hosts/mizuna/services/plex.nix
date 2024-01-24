{ config, ... }:
{
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  environment.persistence."/nix/persist" = {
    directories = [
      config.services.plex.dataDir
    ];
  };
}
