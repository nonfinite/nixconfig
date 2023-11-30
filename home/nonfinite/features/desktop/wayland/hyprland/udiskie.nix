{ ... }:
{
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";
  };
  # home.packages = with pkgs; [
  #   udiskie
  # ];

  # wayland.windowManager.hyprland.settings.exec-once = [
  #   "udiskie"
  # ];
}
