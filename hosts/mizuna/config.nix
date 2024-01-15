let
  defaultPorts = {
    http = 8080;
    https = 8443;

    cooksrv = 8150;

    grafana = 9999;

    loki = 3100;
    promtail.http = 3101;

    prometheus = {
      main = 9998;
      node = 9900;
    };
  };

  allToString = builtins.mapAttrs (k: v:
    if builtins.typeOf v == "int" then
      toString v
    else
      allToString v
  );
in
rec {
  domain = "mizuna.dev";

  defaultUser = "1000";
  defaultGroup = "100";
  defaultUserGroup = "${defaultUser}:${defaultGroup}";

  ports = defaultPorts // {
    str = allToString defaultPorts;
  };

  domains = {
    grafana = "home.${domain}:${ports.str.https}";
  };

  urls = {
    auth = "https://auth.${domain}:${ports.str.https}";
    cooksrv = "https://recipes.${domain}:${ports.str.https}";
    grafana = "https://${domains.grafana}";
  };
}
