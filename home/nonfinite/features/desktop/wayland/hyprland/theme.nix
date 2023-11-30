{ pkgs, ... }:
let
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";

  gtk3-dark = pkgs.writeTextFile {
    name = "gtk3-settings-dark.ini";
    text = ''
      [Settings]
      gtk-theme-name=Adwaita-dark
      gtk-application-prefer-dark-theme=1
    '';
  };
  gtk3-light = pkgs.writeTextFile {
    name = "gtk3-settings-light.ini";
    text = ''
      [Settings]
      gtk-theme-name=Adwaita
      gtk-application-prefer-dark-theme=0
    '';
  };

  theme-set = pkgs.writeTextFile {
    name = "theme-set";
    destination = "/bin/theme-set";
    executable = true;
    text =
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        if [[ "$1" == "light" ]]; then
          echo "Setting light mode..."
          gsettings set org.gnome.desktop.interface gtk-theme Adwaita-light
          gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
          ln -sf ${gtk3-light} ~/.config/gtk-3.0/settings.ini 
        else
          echo "Setting dark mode..."
          gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
          gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
          ln -sf ${gtk3-dark} ~/.config/gtk-3.0/settings.ini 
        fi
      '';
  };
  theme-toggle = pkgs.writeTextFile {
    name = "toggle-theme";
    destination = "/bin/theme-toggle";
    executable = true;
    text =
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        if [[ "$(gsettings get org.gnome.desktop.interface color-scheme)" == "'prefer-dark'" ]]; then
          theme-set light
        else
          theme-set dark
        fi
      '';
  };
in
{
  # https://wiki.archlinux.org/title/Dark_mode_switching
  home.packages = with pkgs; [
    nwg-look
    glib # gsettings
    gnome.adwaita-icon-theme # default gnome icons

    theme-set
    theme-toggle

    # QT
    adwaita-qt6
    adwaita-qt
    libsForQt5.qtstyleplugins
    gsettings-qt
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "theme-set dark"
  ];
}
