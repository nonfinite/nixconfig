{ pkgs, ... }:
let
  borderActive = "rgba(33ccffee) rgba(00ff99ee) 45deg";
  borderInactive = "rgba(595959aa)";
  borderLockedActive = "rgba(33ccffee) rgba(00ff99ee) 45deg";
  borderLockedInactive = "rgba(595959aa)";
in
{
  imports = [
    ../../common/rofi
    ../swayidle.nix
    ../swaylock.nix
    ../swww.nix
    ../waybar
    ./binds.nix
    ./screenshot.nix
    ./theme.nix
    ./tty-init.nix
    ./udiskie.nix
  ];

  home.packages = with pkgs; [
    dunst
    gnome.nautilus
    gnome.eog # for thumbnails in nautilus
    gnome.totem # for thumbnails in nautilus
    # pkgs.inputs.hyprpicker.hyprpicker
    libsForQt5.qt5.qtwayland
    mate.mate-polkit
    qt6.qtwayland
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xorg.xlsclients # useful for detecting applications running via XWayland
  ];

  xdg.userDirs = {
    enable = true;
  };

  home.shellAliases = {
    explorer = "nautilus";
    color-pick = "hyprpicker -a -f hex";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # enable wrapped NixOS apps passing wayland flags
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;

    settings = {

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        ",highres,auto,2"
      ];

      misc = {
        disable_hyprland_logo = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      exec-once = [
        "dunst"
        "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"
        "waybar"
        "alacritty"
        # waybar must be running before these so they show in the tray
        "sleep 1.0s ; syncthingtray"
        "sleep 1.1s ; telegram-desktop"
        "sleep 1.2s ; discord"
        # 1password can have copy problems on wayland, so remove the ozone features if this breaks it
        "sleep 1.3s ; 1password --silent --enable-features=UseOzonePlatform --ozone-platform=wayland"
      ];

      env = [
        "GDK_SCALE,2"
        # "QT_SCALE_FACTOR,2"
        "XCURSOR_SIZE,24"
      ];

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us";
        kb_options = "caps:super";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          scroll_factor = 1.0;
        };

        sensitivity = 0;
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2;
        gaps_out = 2;
        border_size = 2;
        "col.active_border" = borderActive;
        "col.inactive_border" = borderInactive;

        layout = "dwindle";
      };

      group = {
        "col.border_active" = borderActive;
        "col.border_inactive" = borderInactive;

        "col.border_locked_active" = borderLockedActive;
        "col.border_locked_inactive" = borderLockedInactive;

        groupbar = {
          font_family = "DejaVuSansMono Nerd Font";
          font_size = 15;
          gradients = true;
          "col.active" = borderActive;
          "col.inactive" = borderInactive;
          "col.locked_active" = borderLockedActive;
          "col.locked_inactive" = borderLockedInactive;
        };
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
          ignore_opacity = true;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "on";
      };

      # Window rules
      windowrule = [
        "opacity 1.0 override 0.9 override,.*"
      ];

      windowrulev2 = [
        "workspace name:󰍩 silent,class:(org.telegram.desktop)"
        "workspace name:󰍩 silent,class:(discord)"
        "nomaximizerequest,class:(discord)"

        "workspace name: silent,title:^Steam$"
        "workspace name: silent,class:(steam)"

        "dimaround,floating:1,class:(1Password|polkit-mate-authentication-agent-1)"

        "float,class:(firefox),title:^Save"

        # Syncthing popup
        "float,class:(syncthingtray),title:^Syncthing Tray$"
        "move onscreen 100%-0 0,class:(syncthingtray),title:^Syncthing Tray$"
        "dimaround,class:(syncthingtray),title:^Syncthing Tray$"

        # Inhibit idle
        "idleinhibit always,class:(vlc)"
      ];
    };
  };
}
