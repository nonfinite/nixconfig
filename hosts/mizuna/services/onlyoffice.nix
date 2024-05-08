{ mizuna, pkgs, ... }:
let
  storage = "/enc/containers/onlyoffice";
  network = "onlyoffice";
  extraOptions = [ "--network=${network}" ];
in
{
  systemd.services.docker-network-create-onlyoffice = rec {
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    wantedBy = [
      "docker-onlyoffice-documentserver.service"
      "docker-onlyoffice-rabbitmq.service"
      "docker-onlyoffice-postgresql.service"
    ];
    before = wantedBy;
    script = ''
      if ! ${pkgs.docker}/bin/docker network inspect ${network}; then
        ${pkgs.docker}/bin/docker network create ${network}
      fi
    '';
  };

  # based on https://github.com/ONLYOFFICE/Docker-DocumentServer/blob/master/docker-compose.yml
  virtualisation.oci-containers.containers = {
    onlyoffice-documentserver = {
      image = "docker.io/onlyoffice/documentserver:8.0";
      dependsOn = [ "onlyoffice-rabbitmq" "onlyoffice-postgresql" ];
      environment = {
        "DB_TYPE" = "postgres";
        "DB_HOST" = "onlyoffice-postgresql";
        "DB_PORT" = "5432";
        "DB_NAME" = "onlyoffice";
        "DB_USER" = "onlyoffice";
        "AMQP_URI" = "amqp://guest:guest@onlyoffice-rabbitmq";
      };
      extraOptions = extraOptions;
      ports = [
        "${mizuna.ports.str.onlyoffice}:80"
      ];
      volumes = [
        "${storage}/data:/var/www/onlyoffice/Data"
        "${storage}/log:/var/log/onlyoffice"
        "${storage}/cache:/var/lib/onlyoffice/documentserver/App_Data/cache/files"
        "${storage}/public:/var/www/onlyoffice/documentserver-example/public/files"
        "${storage}/fonts:/usr/share/fonts"
      ];
    };

    onlyoffice-rabbitmq = {
      image = "docker.io/library/rabbitmq:3-alpine";
      hostname = "onlyoffice-rabbitmq";
      extraOptions = extraOptions;
    };

    onlyoffice-postgresql = {
      image = "docker.io/library/postgres:12-alpine";
      hostname = "onlyoffice-postgresql";
      environment = {
        "POSTGRES_DB" = "onlyoffice";
        "POSTGRES_USER" = "onlyoffice";
        "POSTGRES_HOST_AUTH_METHOD" = "trust";
      };
      extraOptions = extraOptions;
      volumes = [
        "${storage}/postgresql:/var/lib/postgresql"
      ];
    };
  };
}
