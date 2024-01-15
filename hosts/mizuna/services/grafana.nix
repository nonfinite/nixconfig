{ config, mizuna, ... }:
{
  services.grafana = {
    enable = true;
    dataDir = "/var/lib/grafana";
    settings = {
      server = {
        domain = mizuna.domains.grafana;
        http_port = mizuna.ports.grafana;
        root_url = "${mizuna.urls.grafana}/";
      };
      auth.disable_login_form = true;
      "auth.basic".enabled = false;
      "auth.generic_oauth" = {
        enabled = true;
        name = "Mizuna";
        client_id = "PD48qibx52D70ijfC7Fcjz1Te18xunvwkxwp7IKa";
        client_secret = "$__file{/enc/containers/grafana/oauth_client_secret}";
        scopes = "openid profile email";
        auth_url = "${mizuna.urls.auth}/application/o/authorize/";
        api_url = "${mizuna.urls.auth}/application/o/userinfo/";
        token_url = "${mizuna.urls.auth}/application/o/token/";
      };
    };
  };

  environment.persistence."/nix/persist" = {
    directories = [
      config.services.grafana.dataDir
    ];
  };
}
