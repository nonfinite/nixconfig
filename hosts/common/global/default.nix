{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
}
