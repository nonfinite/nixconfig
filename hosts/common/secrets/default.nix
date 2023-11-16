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
    # Should conform to networking.wireless.environmentFile
    # Current keys are LavenirPass=<password>
    wifi-environment = {
      file = ../../../secrets/wifi-environment.age;
    };
  };
}
