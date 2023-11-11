{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "           , Print, exec, grimblast --notify copy screen"
      "       ALT , Print, exec, grimblast --notify copy active"
      "SUPER SHIFT,     S, exec, grimblast --notify copy area"
    ];
  };
}
