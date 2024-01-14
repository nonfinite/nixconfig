{
  imports = [
    ./caddy
    ./cooksrv.nix
    ./authentik
    ./grafana.nix
    ./prometheus.nix
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];
}
