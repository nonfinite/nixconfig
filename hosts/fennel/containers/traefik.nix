{ config, pkgs, ... }:
let
  domain = config.networking.domain;

  yaml = pkgs.formats.yaml { };

  traefikConfig = {
    api = {
      dashboard = true;
    };

    log = {
      level = "INFO";
      filepath = "/logs/traefik.log";
    };

    global = {
      sendAnonymousUsage = false;
      checkNewVersion = false;
    };

    providers = {
      docker = {
        exposedByDefault = false;
      };
    };

    entrypoints = {
      http = {
        address = ":80";
        http = {
          redirections = {
            entryPoint = {
              to = "https";
              scheme = "https";
            };
          };
        };
      };

      https = {
        address = ":443";
        http = {
          tls = {
            certResolver = "letsencrypt";
            domains = [
              {
                main = domain;
                sans = "*.${domain}";
              }
            ];
          };
        };
      };
    };

    certificatesResolvers = {
      letsencrypt = {
        acme = {
          dnsChallenge.provider = "duckdns";
          email = "acme@${domain}";
          storage = "/letsencrypt/acme.json";
        };
      };
    };
  };

  configFile = yaml.generate "traefik.yml" traefikConfig;
in
{
  virtualisation.oci-containers.containers = {
    traefik = {
      image = "docker.io/traefik:v2.10";
      hostname = "traefik";
      cmd = [ ];
      dependsOn = [ ];
      environmentFiles = [
        # needs to contain DUCKDNS_TOKEN
        "/enc/containers/traefik/.env"
      ];
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.route-traefik.rule" = "Host(`traefik.${domain}`)";
        "traefik.http.routers.route-traefik.service" = "api@internal";
        "traefik.http.routers.route-traefik.entrypoints" = "https";
      };
      ports = [
        "80:80"
        "443:443"
        "8080:8080"
      ];
      user = null;
      volumes = [
        "${configFile}:/etc/traefik/traefik.yml"
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
        "traefik.http.routers.route-whoami.rule" = "Host(`whoami.${domain}`)";
        "traefik.http.routers.route-whoami.entrypoints" = "https";
      };
    };
  };
}
