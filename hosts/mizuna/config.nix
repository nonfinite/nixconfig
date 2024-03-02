let
  defaultPorts = {
    http = 80;
    https = 443;

    cooksrv = 8150;

    grafana = 9999;

    home-assistant = 8123;

    loki = 3100;
    promtail.http = 3101;

    prometheus = {
      main = 9998;
      node = 9900;
    };

    seq = 8152;
    seqIngest = 5341;
    simmer = 8151;

    watchtower = 8152;
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
    grafana = "home.${domain}";
  };

  urls = {
    auth = "https://auth.${domain}";
    cooksrv = "https://recipes.${domain}";
    grafana = "https://${domains.grafana}";
    seq = "https://seq.${domain}";
    simmer = "https://simmer.${domain}";
  };
}
