{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = "caps:super";
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
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "paperwm@paperwm.github.com"
      ];
    };
    "org/gnome/shell/extensions/paperwm" = {
      window-gap = 0;
      horizontal-margin = 0;
      vertical-margin = 0;
      vertical-margin-bottom = 0;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>BackSpace" "<Super>w" ];
      move-down-workspace = [ "<Shift><Super>k" ];
      move-left = [ "<Shift><Super>h" ];
      move-right = [ "<Shift><Super>l" ];
      move-up-workspace = [ "<Shift><Super>j" ];
      switch-down-workspace = [ "<Super>k" ];
      switch-left = [ "<Super>h" ];
      switch-right = [ "<Super>l" ];
      switch-up-workspace = [ "<Super>j" ];
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
