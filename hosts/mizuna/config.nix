let
  defaultPorts = {
    http = 80;
    https = 443;

    cooksrv = 8150;

    grafana = 9999;

    home-assistant = 8123;
    home-assistant-ps5 = 8645;

    loki = 3100;

    nextcloud = 11000;
    onlyoffice = 11001;

    promtail.http = 3101;

    prometheus = {
      main = 9998;
      node = 9900;
    };

    seq = 8152;
    seqIngest = 5341;
    simmer = 8151;

    transmission = 9091;

    watchtower = 8152;
  };

  allToString = builtins.mapAttrs (k: v:
    if builtins.typeOf v == "int" then
      toString v
    else
      allToString v
  );
  host = "mizuna";
  tld = "dev";
in
rec {
  domain = "${host}.${tld}";

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
    transmission = "https://trx.${domain}";
  };
}
