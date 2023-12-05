{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
  ];

  services = {
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  # Fix for autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
