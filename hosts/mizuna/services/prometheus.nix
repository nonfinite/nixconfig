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
        static_configs = [{
          targets = [ "localhost:${mizuna.ports.str.prometheus.node}" ];
        }];
      }
    ];

    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
      port = mizuna.ports.prometheus.node;
    };
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/${config.services.prometheus.stateDir}"
    ];
  };
}
