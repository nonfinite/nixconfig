{
  imports = [
    ./paperwm.nix
  ];

  home.shellAliases = {
    explorer = "nautilus";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".local/share/keyrings"
    ];
  };

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
      gtk-enable-primary-paste = false;
    };
    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      show-banners = false;
    };
    "org/gnome/desktop/notifications/application/webcord" = {
      show-banners = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
      workspace-names = [ "1" "2" "3" "4" "5" ];
    };
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
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
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "discord.desktop:1"
        "org.telegram.desktop.desktop:1"
      ];
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
