{ pkgs, mizuna, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "/enc/containers/jellyfin";
    cacheDir = "/enc/containers/jellyfin/cache";
    user = mizuna.defaultUser;
    group = mizuna.defaultGroup;
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
