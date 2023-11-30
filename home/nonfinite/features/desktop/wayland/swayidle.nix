{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swayidle
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.swayidle}/bin/swayidle"
  ];

  home.file.".config/swayidle/config".text =
    if config.wayland.windowManager.hyprland.enable then ''
      timeout 300 "swaylock -f"
      timeout 330 "hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on"
      timeout 10 "if pgrep -x swaylock; then hyprctl dispatch dpms off; fi" resume "hyprctl dispatch dpms on"
    '' else ''
      timeout 300 "swaylock -f"
    '';
}
