{
  home.file.".config/paperwm/user.css".source = ./paperwm.css;

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "paperwm@paperwm.github.com"
      ];
    };
    "org/gnome/shell/extensions/paperwm" = {
      cycle-width-steps = [ 0.5 1.0 ];
      horizontal-margin = 0;
      vertical-margin = 0;
      vertical-margin-bottom = 0;
      window-gap = 0;
      # Note: find wm_class with Looking Glass: https://wiki.gnome.org/Projects/GnomeShell/LookingGlass
      # Alt+F2, lg, enter
      winprops = with builtins; map toJSON [
        { wm_class = "Alacritty"; preferredWidth = "100%"; }
        { wm_class = "firefox"; preferredWidth = "100%"; }
        { wm_class = "org.telegram.desktop"; preferredWidth = "100%"; }
        { wm_class = "WebCord"; preferredWidth = "100%"; }
      ];
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>BackSpace" "<Super>w" ];
      move-down-workspace = [ "<Shift><Super>j" ];
      move-left = [ "<Shift><Super>h" ];
      move-right = [ "<Shift><Super>l" ];
      move-up-workspace = [ "<Shift><Super>k" ];
      new-window = [ "<Super>n" ];
      switch-down-workspace = [ "<Super>j" ];
      switch-left = [ "<Super>h" ];
      switch-right = [ "<Super>l" ];
      switch-up-workspace = [ "<Super>k" ];
    };
  };
}
