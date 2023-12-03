{ config, ... }:
let
  mod = config.wayland.windowManager.sway.config.modifier;
  alt = "Mod1";
in
{
  wayland.windowManager.sway.config = {
    modes = {
      resize = {
        "Down" = "resize grow height 10 px";
        "Up" = "resize shrink height 10 px";
        "j" = "resize grow height 10 px";
        "k" = "resize shrink height 10 px";

        "Right" = "resize grow width 10 px";
        "Left" = "resize shrink width 10 px";
        "l" = "resize grow width 10 px";
        "h" = "resize shrink width 10 px";

        "Escape" = "mode default";
        "Return" = "mode default";
      };
    };

    keybindings = {
      # General shortcuts
      "${mod}+w" = "kill";
      "${mod}+m" = "exit";
      "${mod}+r" = "exec rofi -show drun -modes drun,run,calc";
      "${alt}+Tab" = "exec rofi -show window";
      "${mod}+Return" = "exec alacritty";
      "${mod}+Shift+Space" = "floating toggle";
      "${mod}+Space" = "focus mode_toggle";

      # Layout
      "${mod}+s" = "layout toggle split";
      "${mod}+f" = "fullscreen toggle";
      "${mod}+t" = "layout toggle split tabbed";
      "${mod}+v" = "splitv";
      "${mod}+Shift+r" = "mode resize";

      # Movement
      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";
      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";
      "${mod}+h" = "focus left";
      "${mod}+j" = "focus down";
      "${mod}+k" = "focus up";
      "${mod}+l" = "focus right";
      "${mod}+Shift+h" = "move left";
      "${mod}+Shift+j" = "move down";
      "${mod}+Shift+k" = "move up";
      "${mod}+Shift+l" = "move right";

      # Workspace functionality by number
      "${mod}+1" = "workspace number 1";
      "${mod}+2" = "workspace number 2";
      "${mod}+3" = "workspace number 3";
      "${mod}+4" = "workspace number 4";
      "${mod}+5" = "workspace number 5";
      "${mod}+6" = "workspace number 6";
      "${mod}+7" = "workspace number 7";
      "${mod}+8" = "workspace number 8";
      "${mod}+9" = "workspace number 9";
      "${mod}+Shift+1" = "move container to workspace number 1";
      "${mod}+Shift+2" = "move container to workspace number 2";
      "${mod}+Shift+3" = "move container to workspace number 3";
      "${mod}+Shift+4" = "move container to workspace number 4";
      "${mod}+Shift+5" = "move container to workspace number 5";
      "${mod}+Shift+6" = "move container to workspace number 6";
      "${mod}+Shift+7" = "move container to workspace number 7";
      "${mod}+Shift+8" = "move container to workspace number 8";
      "${mod}+Shift+9" = "move container to workspace number 9";

      "${mod}+Minus" = "focus scratchpad";
      "${mod}+Shift+Minus" = "scratchpad show";

      # Workspaces, see https://www.reddit.com/r/swaywm/comments/pe5ipl/workspace_next_or_new/
      "${mod}+n" = "exec swaymsg \"workspace $($next_or_new)\"";
      "${mod}+b" = "exec swaymsg \"workspace $($previous_or_first)\"";
      "${mod}+Shift+n" = "exec swaymsg \"move window to workspace $($next_or_new)\"; workspace next";
      "${mod}+Shift+b" = "exec swaymsg \"move window to workspace $($previous_or_first)\"; exec swaymsg \"workspace $($previous_or_first)\"";

      # Currently unused from default config
      "${mod}+a" = "focus parent";
      "${mod}+Shift+c" = "reload";
      "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
    };
  };
}
