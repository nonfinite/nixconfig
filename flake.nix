{
  # nixConfig = {
  #   extra-substituters = [
  #     "https://nix-community.cachix.org"
  #   ];
  #   extra-trusted-public-keys = [
  #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #   ];
  # };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
      globals = import ./globals;
    in
    {
      inherit lib;

      overlays = import ./overlays { inherit inputs outputs; };

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
          specialArgs = { inherit inputs outputs globals; };
        };

        mizuna = lib.nixosSystem {
          system = lib.mkDefault "x86_64-linux";
          modules = [ ./hosts/mizuna ];
          specialArgs = {
            inherit inputs outputs globals;
            mizuna = import ./hosts/mizuna/config.nix;
          };
        };
      };

      homeConfigurations = {
        "nonfinite@cardamom" = lib.homeManagerConfiguration {
          modules = [ ./home/nonfinite/cardamom.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs globals; };
        };

        "nonfinite@mizuna" = lib.homeManagerConfiguration {
          modules = [ ./home/nonfinite/mizuna.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs globals; };
        };
      };
    };
}
