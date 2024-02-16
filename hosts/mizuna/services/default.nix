{
  imports = [
    ./authentik
    ./caddy
    ./cooksrv.nix
    ./gluetun.nix
    ./grafana.nix
    ./home-assistant.nix
    ./plex.nix
    ./prometheus.nix
    ./simmer.nix
    ./youtube-dl.nix
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];
}
