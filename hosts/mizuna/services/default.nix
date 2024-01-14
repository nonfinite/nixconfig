{
  imports = [
    ./caddy
    ./authentik
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];
}
