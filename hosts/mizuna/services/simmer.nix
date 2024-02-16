{ mizuna, ... }:
let
  storage = "/enc/containers/simmer";
  extraOptions = [ ];
in
{
  virtualisation.oci-containers.containers = {
    simmer-web = {
      image = "ghcr.io/nonfinite/recipes:main";
      hostname = "simmer-web";
      user = mizuna.defaultUserGroup;
      extraOptions = extraOptions;
      environment = {
        ORIGIN = mizuna.urls.simmer;
      };
      ports = [
        "${mizuna.ports.str.simmer}:80"
      ];
      volumes = [
        "${storage}:/config"
        "/enc/data/Documents/Recipes:/recipes"
      ];
    };
  };
}
