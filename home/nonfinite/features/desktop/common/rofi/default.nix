{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-power-menu
      pkgs.rofi-emoji
    ];
    extraConfig = {
      kb-mode-next = "Shift+Right,Control+Tab,Super+R";
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, R, exec, rofi -show drun -modes drun,run,calc"
    "ALT, TAB, exec, rofi -show window"
  ];
}
