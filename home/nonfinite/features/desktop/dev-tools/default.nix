{ ... }:
{
  imports = [
    ./beekeeper-studio.nix
    ./chromium.nix
    ./jetbrains.nix
    ./nodejs.nix
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".cache/node"
    ];
  };
}
