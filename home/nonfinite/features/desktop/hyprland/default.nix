{ pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./hyprpaper.nix
    ./screenshot.nix
    ./theme.nix
    ./tty-init.nix
    ./waybar
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;

    settings = {

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        ",highres,auto,2"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      exec-once = [
        "dunst"
        "hyprpaper"
        "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"
        "waybar"
        "kitty"
        "sleep 1s ; syncthingtray"
        "sleep 1s ; telegram-desktop"
        "sleep 2s ; discord"
        "sleep 3s ; 1password"
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
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;
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

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
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
        "workspace name:󰢁 silent,class:(1Password),floating:0"
        "workspace name:󰍩 silent,class:(org.telegram.desktop)"
        "workspace name:󰍩 silent,class:(discord)"
        "nomaximizerequest,class:(discord)"

        "dimaround,floating:1,class:(1Password|polkit-mate-authentication-agent-1)"

        # Syncthing popup
        "float,class:(syncthingtray),title:^Syncthing Tray$"
        "move onscreen 100%-0 0,class:(syncthingtray),title:^Syncthing Tray$"
        "dimaround,class:(syncthingtray),title:^Syncthing Tray$"
      ];
    };
  };

  home.packages = with pkgs; [
    dunst
    gnome.nautilus
    gnome.eog # for thumbnails in nautilus
    gnome.totem # for thumbnails in nautilus
    pkgs.inputs.hyprpicker.hyprpicker
    libsForQt5.qt5.qtwayland
    mate.mate-polkit
    qt6.qtwayland
    rofi-wayland
    xdg-desktop-portal-hyprland
  ];

  home.shellAliases = {
    explorer = "nautilus";
    color-pick = "hyprpicker -a -f hex";
  };
}
