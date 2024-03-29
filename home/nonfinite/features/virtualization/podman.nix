{ pkgs, ... }:
{
  home.packages = with pkgs; [
    podman-desktop
    pkgs.unstable.dive
  ];

  home.sessionVariables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/Podman Desktop/Local Storage"
      ".config/Podman Desktop/Preferences"
      ".local/share/containers"
    ];
  };

  home.file.".config/containers/storage.conf".text = ''
    [storage]
      driver = "overlay"
      graphroot = "/nix/persist/home/nonfinite/.local/share/containers"
  '';
}
