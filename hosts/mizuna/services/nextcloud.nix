{ mizuna, pkgs, ... }:
let
  storage = "/enc/data/nextcloud";
  network = "nextcloud";
  extraOptions = [ "--network=${network}" ];
in
{
  systemd.services.docker-network-create-nextcloud = rec {
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    wantedBy = [
      "docker-nextcloud-db.service"
      "docker-nextcloud-server.service"
    ];
    before = wantedBy;
    script = ''
      if ! ${pkgs.docker}/bin/docker network inspect ${network}; then
        ${pkgs.docker}/bin/docker network create ${network}
      fi
    '';
  };

  virtualisation.oci-containers.containers = {
    nextcloud-server = {
      image = "docker.io/library/nextcloud:29";
      dependsOn = [ "nextcloud-db" ];
      environmentFiles = [ "${storage}/.env" ];
      environment = {
        "MYSQL_HOST" = "nextcloud-db";
      };
      extraOptions = extraOptions;
      ports = [
        "${mizuna.ports.str.nextcloud}:80"
      ];
      volumes = [
        "${storage}/data:/var/www/html"
      ];
    };

    nextcloud-db = {
      image = "docker.io/library/mariadb:10.6";
      hostname = "nextcloud-db";
      environmentFiles = [ "${storage}/.env" ];
      extraOptions = extraOptions;
      volumes = [
        "${storage}/mariadb:/var/lib/mysql"
      ];
    };
  };
}
