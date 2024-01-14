{ config, ... }:
let
  domain = "home.${config.networking.domain}";
  port = "8443";
in
{
  services.grafana = {
    enable = true;
    dataDir = "/var/lib/grafana";
    settings = {
      server = {
        domain = "${domain}:${port}";
        http_port = 9999;
        root_url = "https://${domain}:${port}/";
      };
      auth.disable_login_form = true;
      "auth.basic".enabled = false;
      "auth.generic_oauth" = {
        enabled = true;
        name = "Mizuna";
        client_id = "PD48qibx52D70ijfC7Fcjz1Te18xunvwkxwp7IKa";
        client_secret = "$__file{/enc/containers/grafana/oauth_client_secret}";
        scopes = "openid profile email";
        auth_url = "https://auth.mizuna.dev:8443/application/o/authorize/";
        api_url = "https://auth.mizuna.dev:8443/application/o/userinfo/";
        token_url = "https://auth.mizuna.dev:8443/application/o/token/";
      };
    };
  };

  environment.persistence."/nix/persist" = {
    directories = [
      config.services.grafana.dataDir
    ];
  };
}
