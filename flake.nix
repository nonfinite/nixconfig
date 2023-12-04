{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nix = {
        settings = {
          experimental-features = [ "nix-command" "flakes" "repl-flake" ];
          warn-dirty = false;
        };
      };

      nixosConfigurations = {
        cardamom = lib.nixosSystem {
          system = lib.mkDefault "x86_64-linux";
          modules = [ ./hosts/cardamom ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "nonfinite@cardamom" = lib.homeManagerConfiguration {
          modules = [ ./home/nonfinite/cardamom.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
