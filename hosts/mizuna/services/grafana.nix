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
        role_attribute_path = "contains(groups, 'grafana-admins') && 'Admin' || contains(groups, 'grafana-editors') && 'Editor' || 'Viewer'";
      };
    };

    provision.datasources.settings.datasources = [
      {
        # https://grafana.com/docs/grafana/latest/datasources/prometheus/
        name = "Prometheus";
        type = "prometheus";
        access = "proxy";
        url = "http://localhost:${mizuna.ports.str.prometheus.main}";
      }
      {
        # https://grafana.com/docs/grafana/latest/datasources/loki/
        name = "Loki";
        type = "loki";
        access = "proxy";
        url = "http://localhost:${mizuna.ports.str.loki}";
      }
    ];
  };

  services.loki = {
    enable = true;
    configuration = {
      # https://grafana.com/docs/loki/latest/configure/
      auth_enabled = false;
      server = {
        http_listen_port = mizuna.ports.loki;
      };

      common = {
        ring = {
          instance_addr = "127.0.0.1";
          kvstore.store = "inmemory";
        };
        replication_factor = 1;
        path_prefix = "/tmp/loki";
      };

      schema_config = {
        configs = [
          {
            from = "2024-01-14";
            store = "boltdb-shipper";
            object_store = "filesystem";
            schema = "v11";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }
          {
            from = "2024-06-03";
            store = "tsdb";
            object_store = "gcs";
            schema = "v13";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }
        ];
      };
    };
  };

  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = mizuna.ports.promtail.http;
        grpc_listen_port = 0;
      };

      positions = {
        filename = "/tmp/positions.yaml";
      };

      clients = [
        { url = "http://localhost:${mizuna.ports.str.loki}/loki/api/v1/push"; }
      ];

      scrape_configs = [{
        job_name = "journal";
        journal = {
          max_age = "12h";
          labels = {
            job = "systemd-journal";
            host = config.networking.hostName;
          };
        };
        relabel_configs = [{
          source_labels = [ "__journal__systemd_unit" ];
          target_label = "unit";
        }];
      }];
    };
  };

  environment.persistence."/nix/persist" = {
    directories = [
      config.services.grafana.dataDir
      config.services.loki.dataDir
    ];
  };
}
