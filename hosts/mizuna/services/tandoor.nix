{ pkgs, ... }:
let
  storage = "/enc/containers/tandoor";
  env = "${storage}/.env";
  user = "1000:100";
  network = "tandoor";
  extraOptions = [ "--network=${network}" ];
in
{
  systemd.services.docker-network-create-tandoor = rec {
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    wantedBy = [
      "docker-tandoor-db.service"
      "docker-tandoor-web.service"
    ];
    before = wantedBy;
    script = ''
      if ! ${pkgs.docker}/bin/docker network inspect ${network}; then
        ${pkgs.docker}/bin/docker network create ${network}
      fi
    '';
  };

  virtualisation.oci-containers.containers = {
    tandoor-db = {
      image = "docker.io/library/postgres:15-alpine";
      hostname = "tandoor-db";
      user = user;
      extraOptions = extraOptions;
      environmentFiles = [ env ];
      volumes = [
        "${storage}/db:/var/lib/postgresql/data"
      ];
    };

    tandoor-web = {
      image = "docker.io/vabene1111/recipes:1.5";
      hostname = "tandoor-web";
      user = user;
      extraOptions = extraOptions;
      dependsOn = [ "tandoor-db" ];
      environmentFiles = [ env ];
      ports = [
        "8150:8080"
      ];
      volumes = [
        "${storage}/staticfiles:/opt/recipes/staticfiles"
        "${storage}/mediafiles:/opt/recipes/mediafiles"
      ];
    };
  };
}
