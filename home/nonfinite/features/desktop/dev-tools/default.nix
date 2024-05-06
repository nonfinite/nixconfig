{ ... }:
{
  imports = [
    ./beekeeper-studio.nix
    ./jetbrains.nix
    ./chromium.nix
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".cache/node"
    ];
  };
}
