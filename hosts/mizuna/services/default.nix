{
  imports = [
    ./caddy
    ./cooksrv.nix
    ./authentik
    ./prometheus.nix
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];
}
