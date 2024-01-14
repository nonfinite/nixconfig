{
  imports = [
    ./caddy
    ./cooksrv.nix
    ./authentik
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];
}
