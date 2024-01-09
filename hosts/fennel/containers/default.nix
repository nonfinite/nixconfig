{
  imports = [
    ./traefik.nix
  ];

  virtualisation.oci-containers.backend = "docker";
}
