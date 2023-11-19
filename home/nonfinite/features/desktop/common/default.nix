{ pkgs, ... }:
{
  imports = [
    ./codium.nix
    ./discord.nix
    ./firefox.nix
    ./pinta.nix
    ./system-monitor.nix
    ./telegram.nix
    ./vlc.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
    gtk3
    dconf
  ];

  dconf.settings = {
    "org/gtk/settings/debug" = {
      # Allow Ctrl+Shift+D in GTK apps to open inspector
      enable-inspector-keybinding = true;
    };
  };
}
