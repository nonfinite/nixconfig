{ inputs, pkgs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];

  # Ensure persistent files (e.g. ssh keys) are restored before agenix activates
  system.activationScripts.agenixInstall.deps = [ "persist-files" ];

  age.secrets = {
    wifi-home = {
      file = ../../../secrets/wifi-home.nmconnection.age;
      path = "/etc/NetworkManager/system-connections/wifi-home.nmconnection";
    };
    netdata-claim-token = {
      file = ../../../secrets/netdata.claim-token.age;
      path = "/var/lib/netdata/cloud.d/token";
    };
  };
}
