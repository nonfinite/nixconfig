{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    wl-clipboard
    xdg-user-dirs
    xorg.xlsclients # useful for detecting applications running via XWayland
  ];

  xdg.userDirs = {
    enable = true;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # enable wrapped NixOS apps passing wayland flags
  };

  home.shellAliases = {
    copy = "wl-copy";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
}
