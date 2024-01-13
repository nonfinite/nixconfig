{ pkgs, ... }:
let
  storage = "/enc/containers/authentik";
  env = "${storage}/.env";
  user = "1000:100";
  podname = "authentik";
  extraOptions = [ "--pod=${podname}" ];
  authentikTag = "2023.10.6";
in
{
  # https://discourse.nixos.org/t/podman-container-to-container-networking/11647/2
  systemd.services.podman-authentik-create-pod = rec {
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    wantedBy = [
      "podman-authentik-db.service"
      "podman-authentik-redis.service"
    ];
    before = wantedBy;
    script = ''
      ${pkgs.podman}/bin/podman pod exists ${podname} || \
        ${pkgs.podman}/bin/podman pod create -n ${podname} -p 127.0.0.1:9000:9000 -p 127.0.0.1:9443:9443
    '';
  };

  virtualisation.oci-containers.containers = {
    authentik-db = {
      image = "docker.io/library/postgres:12-alpine";
      user = user;
      extraOptions = extraOptions;
      environment = {
        "POSTGRES_PASSWORD" = "\${PG_PASS}";
        "POSTGRES_USER" = "authentik";
        "POSTGRES_DB" = "authentik";
      };
      environmentFiles = [ env ];
      volumes = [
        "${storage}/db:/var/lib/postgresql/data"
      ];
    };

    authentik-redis = {
      image = "docker.io/library/redis:7-alpine";
      user = user;
      extraOptions = extraOptions;
      cmd = [ "--save" "60" "1" "--loglevel" "warning" ];
      volumes = [
        "${storage}/redis:/data"
      ];
    };

    authentik-server = {
      image = "ghcr.io/goauthentik/server:${authentikTag}";
      user = user;
      extraOptions = extraOptions;
      cmd = [ "server" ];
      dependsOn = [
        "authentik-db"
        "authentik-redis"
      ];
      environment = {
        "AUTHENTIK_REDIS__HOST" = "localhost";
        "AUTHENTIK_POSTGRESQL__HOST" = "localhost";
        "AUTHENTIK_POSTGRESQL__USER" = "authentik";
        "AUTHENTIK_POSTGRESQL__NAME" = "authentik";
        "AUTHENTIK_POSTGRESQL__PASSWORD" = "\${PG_PASS}";
      };
      environmentFiles = [ env ];
      volumes = [
        "/enc/containers/authentik/server/media:/media"
        "/enc/containers/authentik/server/templates:/templates"
      ];
    };

    authentik-worker = {
      image = "ghcr.io/goauthentik/server:${authentikTag}";
      user = user;
      extraOptions = extraOptions;
      cmd = [ "worker" ];
      dependsOn = [
        "authentik-db"
        "authentik-redis"
      ];
      environment = {
        "AUTHENTIK_REDIS__HOST" = "localhost";
        "AUTHENTIK_POSTGRESQL__HOST" = "localhost";
        "AUTHENTIK_POSTGRESQL__USER" = "authentik";
        "AUTHENTIK_POSTGRESQL__NAME" = "authentik";
        "AUTHENTIK_POSTGRESQL__PASSWORD" = "\${PG_PASS}";
      };
      environmentFiles = [ env ];
      volumes = [
        "/enc/containers/authentik/server/media:/media"
        "/enc/containers/authentik/server/certs:/certs"
        "/enc/containers/authentik/server/templates:/templates"
      ];
    };
  };
}
