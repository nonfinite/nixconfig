{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    gnomeExtensions.appindicator
    gnomeExtensions.material-shell
    gnomeExtensions.pop-shell
  ];

  services = {
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb.options = "caps:super";
    };
  };

  # Fix for autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
