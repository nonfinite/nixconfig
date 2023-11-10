{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
          specialArgs = { inherit inputs outputs; };
        };
        vbox = lib.nixosSystem {
          system = lib.mkDefault "x86_64-linux";
          modules = [ ./hosts/vbox ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "nonfinite@cardamom" = lib.homeManagerConfiguration {
          modules = [ ./home/nonfinite/cardamom.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "nonfinite@vbox" = lib.homeManagerConfiguration {
          modules = [ ./home/nonfinite/vbox.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
