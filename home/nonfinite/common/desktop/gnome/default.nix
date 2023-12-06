{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:super" ];
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = false;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      num-workspaces = 5;
      workspace-names = [ "1" "2" "3" "4" "5" ];
    };
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "paperwm@paperwm.github.com"
      ];
    };
    "org/gnome/shell/extensions/paperwm" = {
      cycle-width-steps = [ 0.3 0.5 0.7 ];
      horizontal-margin = 0;
      vertical-margin = 0;
      vertical-margin-bottom = 0;
      window-gap = 0;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>BackSpace" "<Super>w" ];
      move-down-workspace = [ "<Shift><Super>j" ];
      move-left = [ "<Shift><Super>h" ];
      move-right = [ "<Shift><Super>l" ];
      move-up-workspace = [ "<Shift><Super>k" ];
      switch-down-workspace = [ "<Super>j" ];
      switch-left = [ "<Super>h" ];
      switch-right = [ "<Super>l" ];
      switch-up-workspace = [ "<Super>k" ];
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };
    "org/gtk/settings/file-chooser" = {
      show-hidden = true;
    };
  };
}
