{ pkgs, ... }:
{
  imports = [
    ./waybar
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;

    settings = {

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        ",preferred,auto,2"
      ];

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      exec-once = [
        "dunst"
        "polkit-kde-agent"
        "waybar"
        "kitty"
        "sleep 1s ; telegram-desktop"
        "sleep 2s ; discord"
        "sleep 3s ; 1password"
      ];

      env = [
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

      "$mainMod" = "SUPER";

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, Q, exec, kitty"
        "$mainMod, W, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, S, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Move/resize windows with mainMod + SHIFT + HJKL
        "$mainMod SHIFT, H, resizeactive, -10   0"
        "$mainMod SHIFT, L, resizeactive,  10   0"
        "$mainMod SHIFT, K, resizeactive,   0 -10"
        "$mainMod SHIFT, J, resizeactive,   0  10"

        #
        # Custom
        #

        # App Launcher
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, TAB, exec, rofi -show window"


        # Move focus with mainMod + hjkl
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Toggle fullscreen with bars
        "$mainMod, F, fullscreen, 1"

        # Toggle true fullscreen
        "$mainMod SHIFT, F, fullscreen, 0"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrulev2 = [
        "workspace name:󰢁 silent,class:(1Password),floating:0"
        "workspace name:󰍩 silent,class:(org.telegram.desktop)"
        "workspace name:󰍩 silent,class:(discord)"
        "nomaximizerequest,class:(discord)"
      ];
    };
  };

  # home.file.".config/hypr/hyprland.conf".source = ../../../.config/hypr/hyprland.conf;

  home.packages = with pkgs; [
    dunst
    gnome.nautilus
    gnome.eog # for thumbnails in nautilus
    gnome.totem # for thumbnails in nautilus
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    rofi-wayland
    xdg-desktop-portal-hyprland
  ];

  home.shellAliases = {
    explorer = "nautilus";
  };
}
