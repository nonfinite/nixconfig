{ config, ... }:
let
  domain = "auth.${config.networking.domain}";
in
{
  virtualisation.oci-containers.containers = {
    keycloak = {
      image = "quay.io/keycloak/keycloak:23.0";
      hostname = "keycloak";
      extraOptions = [ "--network=fennel" ];
      cmd = [
        "start"
        "--features=declarative-user-profile"
      ];
      dependsOn = [ "traefik" ];
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

    oauth2proxy = {
      # internal: oauth2proxy on port 4180
      image = "quay.io/oauth2-proxy/oauth2-proxy:v7.5.1";
      hostname = "oauth2proxy";
      extraOptions = [ "--network=fennel" ];
      cmd = [ ];
      environment = {
        "OAUTH2_PROXY_HTTP_ADDRESS" = "0.0.0.0:4180";

        # OAUTH2_PROXY_COOKIE_SECRET = from env files
        "OAUTH2_PROXY_COOKIE_DOMAINS" = ".${config.networking.domain}"; # Required so cookie can be read on all subdomains.
        "OAUTH2_PROXY_WHITELIST_DOMAINS" = ".${config.networking.domain}"; # Required to allow redirection back to original requested target.

        # Configure to use Keycloak
        "OAUTH2_PROXY_PROVIDER" = "oidc";
        "OAUTH2_PROXY_CLIENT_ID" = "oauth2-proxy";
        # OAUTH2_PROXY_CLIENT_SECRET = from env files
        "OAUTH2_PROXY_EMAIL_DOMAINS" = "*";
        "OAUTH2_PROXY_OIDC_ISSUER_URL" = "https://${domain}:8443/realms/fennel";
        "OAUTH2_PROXY_REDIRECT_URL" = "https://${domain}:8443/oauth2/callback";

        "OAUTH2_PROXY_COOKIE_CSRF_PER_REQUEST" = "true";
        "OAUTH2_PROXY_COOKIE_CSRF_EXPIRE" = "5m";
        "OAUTH2_PROXY_CUSTOM_TEMPLATES_DIR" = "/templates";
        "OAUTH2_PROXY_REVERSE_PROXY" = "true";

        # Options
        "OAUTH2_PROXY_SET_XAUTHREQUEST" = "true";
      };
      dependsOn = [
        "keycloak"
        "traefik"
      ];
      environmentFiles = [
        "/enc/containers/oauth2proxy/.env"
      ];
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.route-authproxy.rule" = "(Host(`${domain}`) && PathPrefix(`/oauth2/`)) || (PathPrefix(`/oauth2/`))";
        "traefik.http.services.route-authproxy.loadbalancer.server.port" = "4180";
      };
      volumes = [
        "/enc/containers/oauth2proxy/templates:/templates:ro"
      ];
    };
  };

  # oauth2proxy often fails to start initially if traefik isn't fully started
  # as it will try to load the oauth config immediately.
  # This ensures it doesn't trigger the burst limit when it retries.
  systemd.services.docker-oauth2proxy.serviceConfig = {
    RestartSec = "5s";
  };
}
