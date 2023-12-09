{ pkgs, ... }:
{
  home.packages = with pkgs; [
    beekeeper-studio
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/beekeeper-studio"
    ];
  };
}
