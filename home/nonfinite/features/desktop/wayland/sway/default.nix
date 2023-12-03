{ pkgs, ... }:
{
  imports = [
    ../../common/rofi
    ../global.nix
    ../swayidle.nix
    ../swaylock.nix
    ../swww.nix
    ../waybar
    ./binds.nix
    ./windows.nix
  ];

  home.packages = with pkgs; [
    dunst
    jq
  ];

  wayland.windowManager.sway = {
    enable = true;
    extraConfigEarly = ''
      set $next_or_new swaymsg -r -t get_workspaces | jq -r --arg OUTPUT $(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused == true) | .name') '(. | (max_by(.num) | .num)) as $max | [.[] | select(.output == $OUTPUT)] | (max_by(.num) | .num) as $maxOutput | (.[] | select(.focused == true) | .num) as $current | if $maxOutput > $current then "next_on_output" else $max + 1 end'
      set $previous_or_first swaymsg -r -t get_workspaces | jq -r --arg OUTPUT $(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused == true) | .name') '(. | (max_by(.num) | .num)) as $max | [.[] | select(.output == $OUTPUT)] | (min_by(.num) | .num) as $minOutput | (.[] | select(.focused == true) | .num) as $current | if $minOutput < $current then "prev_on_output" else $current end'
    '';
    config = {
      modifier = "Mod4"; # SUPER/Windows
      terminal = "alacritty";
      startup = [
        { command = "set-wp-random"; always = true; }
        { command = "dunst"; }
        # { command = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"; }
        { command = "waybar"; }

        # waybar must be running before these so they show in the tray
        { command = "alacritty"; }
        { command = "sleep 1.0s && syncthingtray"; }
        { command = "sleep 1.1s && telegram-desktop"; }
        { command = "sleep 1.2s && discord"; }
        { command = "sleep 1.3s && 1password --silent"; }
      ];

      input = {
        "*" = {
          xkb_options = "caps:super";
        };
      };
    };
  };

  home.shellAliases = {
    Sway = "sway";
    sm-tree = "swaymsg -t get_tree";
    sm-app-id = "swaymsg -t get_tree | grep app_id";
  };
}
