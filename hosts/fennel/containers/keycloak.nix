{ config, ... }:
let
  domain = "auth.${config.networking.domain}";
in
{
  virtualisation.oci-containers.containers = {
    keycloak = {
      image = "quay.io/keycloak/keycloak:23.0";
      hostname = "keycloak";
      cmd = [ "start" ];
      environment = {
        KC_HOSTNAME_URL = "https://${domain}:8443/";
        KC_PROXY = "edge";
        KEYCLOAK_LOGLEVEL = "INFO";
        # Uncomment these to bootstrap a new instance
        # KEYCLOAK_ADMIN = "admin";
        # KEYCLOAK_ADMIN_PASSWORD = "admin";
      };
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.route-auth.rule" = "Host(`${domain}`)";
        "traefik.http.routers.route-auth.entrypoints" = "https";
        "traefik.http.routers.route-auth.middlewares" = "default@file,redirect-index-admin";
        # redirect / to /admin
        "traefik.http.middlewares.redirect-index-admin.redirectregex.regex" = "^https:\\/\\/([^\\/]+)\\/?$";
        "traefik.http.middlewares.redirect-index-admin.redirectregex.replacement" = "https://$1/admin";
      };
      volumes = [
        "/enc/containers/keycloak:/opt/keycloak/data"
      ];
    };
  };
}
