{
  imports = [
    ./keycloak.nix
    ./traefik.nix
  ];

  virtualisation.oci-containers.backend = "docker";
}
