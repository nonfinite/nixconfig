{ config, mizuna, ... }:
{
  services.prometheus = {
    enable = true;
    listenAddress = "localhost";
    port = mizuna.ports.prometheus.main;
    stateDir = "prometheus2";

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
            targets = [ "localhost:${mizuna.ports.str.prometheus.main}" ];
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
