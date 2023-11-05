{
  home.shellAliases = {
    explorer = "nautilus";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };

  dconf.settings = {
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = false;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
    };
    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      show-banners = false;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = [ "<Super>Down" ];
      unmaximize = [ ];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "Move_Clock@rmy.pobox.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "NotificationCounter@coolllsk"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "org.telegram.desktop.desktop"
        "discord.desktop"
        "steam.desktop"
      ];
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
      sleep-inactive-ac-type = "nothing";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };
    "org/gtk/settings/file-chooser" = {
      show-hidden = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
  };
}
