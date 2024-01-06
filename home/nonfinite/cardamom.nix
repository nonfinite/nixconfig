{
  imports = [
    ./global
    ./global/exec-once.nix
    ./features/desktop/common
    ./features/desktop/dev-tools
    ./features/desktop/gnome
    ./features/games
    ./features/rust.nix
    ./features/virtualization/podman.nix
    ./features/virtualization/virt-manager.nix
  ];

  exec-once.commands = [ "1password --silent" ];

  dconf.settings = {
    "org/virt-manager/virt-manager/vms/4a69e3b8ab34492b88b7945c658619dc" = {
      autoconnect = 1;
      scaling = 2;
    };
  };
}
