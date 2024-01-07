{ pkgs, ... }:
{
  home.packages = with pkgs; [
    podman-desktop
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/Podman Desktop/Local Storage"
      ".config/Podman Desktop/Preferences"
      ".local/share/containers"
    ];
  };
}
