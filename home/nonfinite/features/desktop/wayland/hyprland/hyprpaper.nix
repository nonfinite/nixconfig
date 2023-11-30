{ pkgs, ... }:
let
  # wp = "${../../../../../images/lakeside_sunset.png}";
  wp = "${../../../../../images/firewatch.jpg}";
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${wp}
    wallpaper = ,${wp}
  '';
}
