{
  wayland.windowManager.hyprland.settings = {
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
  };
}
