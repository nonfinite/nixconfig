{
  imports = [
    ./caddy
    ./cooksrv.nix
    ./authentik
    ./home-assistant.nix
    ./grafana.nix
    ./prometheus.nix
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];
}
