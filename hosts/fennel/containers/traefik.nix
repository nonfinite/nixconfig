{ config, ... }:
{
  virtualisation.oci-containers.containers = {
    traefik = {
      image = "docker.io/traefik:v2.10";
      hostname = "traefik";
      cmd = [
        "--api=true"
        "--api.insecure=true"

        "--log.level=INFO" # DEBUG, PANIC, FATAL, ERROR, WARN, INFO
        "--log.filepath=/logs/traefik.log"

        "--global.sendAnonymousUsage=false"
        "--global.checkNewVersion=false"

        "--providers.docker=true"
        "--providers.docker.exposedbydefault=false"

        "--entrypoints.http.address=:80"
        "--entrypoints.http.http.redirections.entryPoint.to=https"
        "--entrypoints.http.http.redirections.entryPoint.scheme=https"

        "--entrypoints.https.address=:443"
        "--entrypoints.https.http.tls.certResolver=le-resolver"
        "--entrypoints.https.http.tls.domains[0].main=${config.networking.domain}"
        "--entrypoints.https.http.tls.domains[0].sans=*.${config.networking.domain}"

        "--certificatesresolvers.le-resolver.acme.dnsChallenge.provider=duckdns"
        "--certificatesresolvers.le-resolver.acme.email=acme@${config.networking.domain}"
        "--certificatesresolvers.le-resolver.acme.storage=/letsencrypt/acme.json"
      ];
      dependsOn = [ ];
      environmentFiles = [
        # needs to contain DUCKDNS_TOKEN
        "/enc/containers/traefik/.env"
      ];
      labels = { };
      ports = [
        "80:80"
        "443:443"
        "8080:8080"
      ];
      user = null;
      volumes = [
        "/enc/containers/traefik/logs:/logs"
        "/enc/containers/traefik/letsencrypt:/letsencrypt"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
    };

    whoami = {
      image = "docker.io/traefik/whoami";
      hostname = "whoami";
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.whoami.rule" = "Host(`whoami.${config.networking.domain}`)";
        "traefik.http.routers.whoami.entrypoints" = "https";
      };
    };
  };
}
