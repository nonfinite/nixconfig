{ config, ... }:
let
  domain = config.networking.domain;
  storage = "/enc/containers/cooksrv";
  env = "${storage}/.env";
  user = "1000:100";
  extraOptions = [ ];
in
{
  virtualisation.oci-containers.containers = {
    cooksrv-web = {
      image = "ghcr.io/nonfinite/cooksrv:main";
      hostname = "cooksrv-web";
      user = user;
      extraOptions = extraOptions;
      environment = {
        ORIGIN = "https://recipes.${domain}:8443";
      };
      environmentFiles = [ env ];
      ports = [
        "8150:80"
      ];
      volumes = [
        "${storage}:/config"
        "/enc/data/Documents/Recipes:/recipes"
      ];
    };
  };
}
