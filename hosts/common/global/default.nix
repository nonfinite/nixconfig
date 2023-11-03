{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
}
