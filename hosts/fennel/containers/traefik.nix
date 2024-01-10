{ config, pkgs, ... }:
let
  domain = config.networking.domain;

  yaml = pkgs.formats.yaml { };

  traefikDotYml = yaml.generate "traefik.yml" {
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
      file = {
        directory = "/conf.d";
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
          middlewares = [
            "default@file"
          ];
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

  traefikDynamicDefaultDotYml = yaml.generate "traefik_dynamic_default.yml" {
    http = {
      middlewares = {
        default = {
          chain = {
            middlewares = [
              "default-security-headers"
              "gzip"
            ];
          };
        };

        default-security-headers = {
          headers = {
            browserXssFilter = true; # X-XSS-Protection=1; mode=block
            contentTypeNosniff = true; # X-Content-Type-Options=nosniff
            customResponseHeaders = {
              X-Robots-Tag = "noindex, nofollow";
            };
            forceSTSHeader = true; # Add the Strict-Transport-Security header even when the connection is HTTP
            referrerPolicy = "strict-origin-when-cross-origin";
            stsIncludeSubdomains = true; # Add includeSubdomains to the Strict-Transport-Security header
            stsPreload = true; # Add preload flag appended to the Strict-Transport-Security header
            stsSeconds = 63072000; # Set the max-age of the Strict-Transport-Security header (63072000 = 2 years)
          };
        };

        gzip = {
          compress = { };
        };
      };
    };

    tls = {
      options = {
        default = {
          sniStrict = true;
        };
      };
    };
  };
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
        "${traefikDotYml}:/etc/traefik/traefik.yml"
        "${traefikDynamicDefaultDotYml}:/conf.d/traefik_dynamic_default.yml"
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
