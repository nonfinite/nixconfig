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
}
