{ config, lib, pkgs, ... }:
let
  containers = config.virtualisation.oci-containers.containers;
  containerNames = lib.lists.sort (a: b: a < b) (lib.lists.unique (builtins.attrNames containers));
  lines = builtins.map
    (name: ''
      if [[ $EUID -ne 0 ]]; then
        echo "Script must be run as root, elevating..."
        sudo "$0" "$@"
        exit $?
      fi

      if ! ${pkgs.docker}/bin/docker pull ${(builtins.getAttr name containers).image} | grep "Image is up to date"; then
        echo "UPDATED: ${name}"
        systemctl restart docker-${name}.service
      fi
    '')
    containerNames;
  update-containers = pkgs.writeShellScriptBin "update-containers" ''
    export LANG=C

    ${builtins.concatStringsSep "\n\n" lines}
  '';
in
{
  imports = [
    ./authentik
    ./caddy
    ./cooksrv.nix
    ./gluetun.nix
    ./grafana.nix
    ./home-assistant.nix
    ./plex.nix
    ./prometheus.nix
    ./simmer.nix
    ./youtube-dl.nix
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];

  environment.systemPackages = [ update-containers ];
}
