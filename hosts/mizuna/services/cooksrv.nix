{ mizuna, ... }:
let
  storage = "/enc/containers/cooksrv";
  env = "${storage}/.env";
  extraOptions = [ ];
in
{
  virtualisation.oci-containers.containers = {
    cooksrv-web = {
      image = "ghcr.io/nonfinite/cooksrv:main";
      hostname = "cooksrv-web";
      user = mizuna.defaultUserGroup;
      extraOptions = extraOptions;
      environment = {
        ORIGIN = mizuna.urls.cooksrv;
      };
      environmentFiles = [ env ];
      ports = [
        "${mizuna.ports.str.cooksrv}:80"
      ];
      volumes = [
        "${storage}:/config"
        "/enc/data/Documents/Recipes:/recipes"
      ];
    };
  };
}
