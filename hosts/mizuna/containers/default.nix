{
  imports = [
    ./keycloak.nix
    ./traefik.nix
  ];

  virtualisation.oci-containers.backend = "docker";

  # A default bridge network named "fennel" is required:
  # sudo docker network create -d bridge fennel
}
