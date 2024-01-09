{ config, ... }:
{
  virtualisation.oci-containers.containers = {
    traefik = {
      image = "docker.io/traefik:v2.10";
      hostname = "traefik";
      cmd = [
        "--api=true"
        "--api.insecure=true"
        "--global.sendAnonymousUsage=false"
        "--global.checkNewVersion=false"
        "--providers.docker=true"
        "--providers.docker.exposedbydefault=false"
        "--entrypoints.http.address=:80"
      ];
      dependsOn = [ ];
      environmentFiles = [ ];
      labels = { };
      ports = [
        "80:80"
        "8080:8080"
      ];
      user = null;
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
    };

    whoami = {
      image = "docker.io/traefik/whoami";
      hostname = "whoami";
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.whoami.rule" = "Host(`whoami.${config.networking.domain}`)";
        "traefik.http.routers.whoami.entrypoints" = "http";
      };
    };
  };
}
