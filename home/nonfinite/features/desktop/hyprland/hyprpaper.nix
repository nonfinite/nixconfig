{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${./img/lakeside_sunset.png}
    wallpaper = ,${./img/lakeside_sunset.png}
  '';
}
