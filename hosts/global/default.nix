{ inputs, outputs, lib, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "home-manager=${inputs.home-manager.outPath}"
    ];
  };

  environment.shellAliases = {
    ll = "ls -la";
    cls = "clear";

    nd = "nix develop";
    hm = "home-manager --flake .";
    hms = "home-manager --flake . switch";
  };

  security.polkit.enable = true;

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
}
