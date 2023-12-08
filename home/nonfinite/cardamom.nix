{
  imports = [
    ./global
    ./global/exec-once.nix
    ./features/desktop/common
    ./features/desktop/dev-tools
    ./features/desktop/gnome
    ./features/games
    ./features/virtualization/podman.nix
  ];

  exec-once.commands = [ "1password --silent" ];
}
