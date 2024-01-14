{ config, ... }:
{
  services.prometheus = {
    enable = true;
    listenAddress = "localhost";
    port = 9090;
    stateDir = "prometheus2";
    webExternalUrl = "https://home.mizuna.dev:8443/";

    globalConfig = {
      scrape_interval = "15s";
      external_labels = {
        monitor = "mizuna-monitor";
      };
    };

    scrapeConfigs = [
      {
        job_name = "prometheus";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = [ "localhost:9090" ];
          }
        ];
      }
    ];
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/${config.services.prometheus.stateDir}"
    ];
  };
}
