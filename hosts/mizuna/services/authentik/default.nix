{ pkgs, mizuna, ... }:
let
  storage = "/enc/containers/authentik";
  env = "${storage}/.env";
  network = "authentik";
  extraOptions = [ "--network=${network}" ];
  authentikTag = "2023.10.6";
in
{
  systemd.services.docker-network-create-authentik = rec {
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    wantedBy = [
      "docker-authentik-db.service"
      "docker-authentik-redis.service"
      "docker-authentik-server.service"
      "docker-authentik-worker.service"
    ];
    before = wantedBy;
    script = ''
      if ! ${pkgs.docker}/bin/docker network inspect ${network}; then
        ${pkgs.docker}/bin/docker network create ${network}
      fi
    '';
  };

  virtualisation.oci-containers.containers = {
    authentik-db = {
      image = "docker.io/library/postgres:12-alpine";
      hostname = "authentik-db";
      user = mizuna.defaultUserGroup;
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
      hostname = "authentik-redis";
      user = mizuna.defaultUserGroup;
      extraOptions = extraOptions;
      cmd = [ "--save" "60" "1" "--loglevel" "warning" ];
      volumes = [
        "${storage}/redis:/data"
      ];
    };

    authentik-server = {
      image = "ghcr.io/goauthentik/server:${authentikTag}";
      hostname = "authentik-server";
      user = mizuna.defaultUserGroup;
      extraOptions = extraOptions;
      cmd = [ "server" ];
      dependsOn = [
        "authentik-db"
        "authentik-redis"
      ];
      environment = {
        "AUTHENTIK_REDIS__HOST" = "authentik-redis";
        "AUTHENTIK_POSTGRESQL__HOST" = "authentik-db";
        "AUTHENTIK_POSTGRESQL__USER" = "authentik";
        "AUTHENTIK_POSTGRESQL__NAME" = "authentik";
        "AUTHENTIK_POSTGRESQL__PASSWORD" = "\${PG_PASS}";
      };
      environmentFiles = [ env ];
      ports = [ "9000:9000" ];
      volumes = [
        "/enc/containers/authentik/server/media:/media"
        "/enc/containers/authentik/server/templates:/templates"
        "/enc/containers/authentik/server/custom.css:/web/dist/custom.css"
      ];
    };

    authentik-worker = {
      image = "ghcr.io/goauthentik/server:${authentikTag}";
      hostname = "authentik-worker";
      user = "root:root";
      # Authentik Worker has a bug where large nofile values cause it to use excessive CPU
      extraOptions = extraOptions ++ ["--ulimit" "nofile=10240:10240"];
      cmd = [ "worker" ];
      dependsOn = [
        "authentik-db"
        "authentik-redis"
      ];
      environment = {
        "AUTHENTIK_REDIS__HOST" = "authentik-redis";
        "AUTHENTIK_POSTGRESQL__HOST" = "authentik-db";
        "AUTHENTIK_POSTGRESQL__USER" = "authentik";
        "AUTHENTIK_POSTGRESQL__NAME" = "authentik";
        "AUTHENTIK_POSTGRESQL__PASSWORD" = "\${PG_PASS}";
      };
      environmentFiles = [ env ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/enc/containers/authentik/server/media:/media"
        "/enc/containers/authentik/server/certs:/certs"
        "/enc/containers/authentik/server/templates:/templates"
      ];
    };
  };
}
