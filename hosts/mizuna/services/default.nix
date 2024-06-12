{ config, lib, pkgs, ... }:
let
  containers = config.virtualisation.oci-containers.containers;
  containerNameAndImage = lib.attrsets.mapAttrsToList (name: value: { inherit name; inherit (value) image; }) containers;
  containersByImage = builtins.groupBy (c: c.image) containerNameAndImage;
  imageNames = lib.lists.sort (a: b: a < b) (builtins.attrNames containersByImage);

  lines = builtins.map
    (image:
      let
        containerNames = builtins.getAttr image containersByImage;
        restartLines = builtins.map (c: "  echo \"UPDATED: ${c.name}\"\n  systemctl restart docker-${c.name}.service\n") containerNames;
      in
      ''
        if ! ${pkgs.docker}/bin/docker pull ${image} | grep "Image is up to date"; then
        ${builtins.concatStringsSep "\n" restartLines}
        fi
      ''
    )
    imageNames;

  update-containers = pkgs.writeShellScriptBin "update-containers" ''
    export LANG=C
    if [[ $EUID -ne 0 ]]; then
      echo "Script must be run as root, elevating..."
      sudo "$0" "$@"
      exit $?
    fi

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
    ./nextcloud.nix
    ./plex.nix
    ./prometheus.nix
    ./pyload.nix
    ./seq.nix
    ./simmer.nix
    ./transmission.nix
    ./youtube-dl.nix
    (import ./syncthing.nix { config = "/enc/containers"; data = "/enc/data"; })
  ];

  environment.systemPackages = [ update-containers ];
}
