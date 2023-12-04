# https://nixos.wiki/wiki/Sway
{ pkgs, ... }:
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Adwaita'
      '';
  };
in
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
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    gnome3.adwaita-icon-theme # default gnome cursors

    xdg-desktop-portal
    xdg-desktop-portal-wlr

    dunst # notifications
    jq # needed for bash scripts for sway
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
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
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
