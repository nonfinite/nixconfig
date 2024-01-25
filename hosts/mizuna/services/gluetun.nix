{ ... }:
{
  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "ghcr.io/qdm12/gluetun";
      hostname = "gluetun";
      extraOptions = [ "--cap-add=NET_ADMIN" ];
      environmentFiles = [ "/enc/containers/gluetun/.env" ];
      ports = [ "8118" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8118 ];
}
