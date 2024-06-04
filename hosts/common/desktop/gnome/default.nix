{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.move-clock
    gnomeExtensions.notification-counter
    gnomeExtensions.paperwm
    gnomeExtensions.pop-shell
  ];

  programs.dconf.enable = true;

  services = {
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb.options = "caps:super";
      excludePackages = [ pkgs.xterm ];
    };
  };

  # Fix for autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Exclude built-in gnome applications
  environment.gnome.excludePackages = with pkgs.gnome; [
    baobab # disk usage analyzer
    cheese # photo booth
    eog # image viewer
    epiphany # web browser
    pkgs.gedit # text editor
    simple-scan # document scanner
    # totem       # video player - allowed for thumbnails
    yelp # help viewer
    evince # document viewer
    # file-roller # archive manager - allowed for archives files
    geary # email client
    seahorse # password manager

    # these should be self explanatory
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-music # gnome-photos
    gnome-weather
    gnome-disk-utility
    pkgs.gnome-connections
    pkgs.gnome-tour
    # gnome-logs gnome-screenshot gnome-system-monitor
  ];
}
