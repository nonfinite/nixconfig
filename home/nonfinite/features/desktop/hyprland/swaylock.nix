{ pkgs, ... }:
let
  red = "803147";
  pink = "D75770";
  blue = "272746";
  green = "1B2B33";
  dark = "0D1D33";
  orange = "D2725C";
  color-key = red;
  color-line = dark;
  color-ring = orange;
  color-ring-clear = pink;
  color-text = pink;
  color-wrong = red;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      daemonize = true;
      show-failed-attempts = true;
      clock = true;
      image = "${../../../../../images/clockbirds/a7349b0452c02e9bfc00cde1f318c137.png}";
      effect-blur = "1x1";
      effect-vignette = "1:1";
      color = "1f1d2e80";
      font = "DejaVuSansMono Nerd Font";
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 10;
      line-color = color-line;
      ring-color = color-ring;
      inside-color = color-line;
      key-hl-color = color-key;
      separator-color = "00000000";
      text-color = color-text;
      text-caps-lock-color = "";
      line-ver-color = color-key;
      ring-ver-color = color-key;
      inside-ver-color = color-line;
      text-ver-color = color-text;
      ring-wrong-color = color-wrong;
      text-wrong-color = color-wrong;
      inside-wrong-color = color-line;
      inside-clear-color = color-line;
      text-clear-color = color-text;
      ring-clear-color = color-ring-clear;
      line-clear-color = color-line;
      line-wrong-color = color-line;
      bs-hl-color = color-wrong;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%a, %B %e";
      timestr = "%I:%M %p";
      fade-in = 0.1;
      ignore-empty-password = true;
    };
  };
}
