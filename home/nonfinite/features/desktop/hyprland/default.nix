{ pkgs, ... }:
{
  home.file.".config/hypr/hyprland.conf".source = ../../../.config/hypr/hyprland.conf;

  home.packages = with pkgs; [
    dunst
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-desktop-portal-hyprland
  ];
}
