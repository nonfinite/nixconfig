{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./codium.nix
    ./discord.nix
    ./firefox.nix
    ./meld.nix
    # ./obsidian.nix # currently insecure due to outdated electron
    ./pinta.nix
    ./rdp.nix
    ./sigil.nix
    ./syncthing.nix
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
