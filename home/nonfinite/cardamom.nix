{
  imports = [
    ./global
    ./features/desktop/common
    ./features/desktop/dev-tools
    ./features/desktop/wayland/sway
    ./features/desktop/wayland/sway/tty-init.nix
    ./features/games
    ./features/virtualization/podman.nix
  ];
}
