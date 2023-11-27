{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "group,class:Alacritty"
  ];
}
