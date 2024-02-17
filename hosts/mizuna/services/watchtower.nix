{ mizuna, pkgs, ... }:
let
  update-containers = pkgs.writeShellScriptBin "update-containers" ''
    sudo docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock docker.io/containrrr/watchtower --run-once
  '';
in
{
  virtualisation.oci-containers.containers = {
    watchtower = {
      image = "docker.io/containrrr/watchtower";
      hostname = "watchtower";
      cmd = [ "--http-api-update" "--http-api-periodic-polls" ];
      environmentFiles = [ "/enc/containers/watchtower/.env" ];
      ports = [
        "${mizuna.ports.str.watchtower}:8080"
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
  };

  environment.systemPackages = [ update-containers ];
}
