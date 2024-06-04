{ ... }:
let
  themes = builtins.fetchGit {
    url = "https://github.com/alacritty/alacritty-theme.git";
    rev = "94e1dc0b9511969a426208fbba24bd7448493785";
  };
  # see themes at https://github.com/alacritty/alacritty-theme
  theme-name = "citylights";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${themes.outPath}/themes/${theme-name}.yaml"
      ];
      keyboard.bindings = [
        { mods = "Control"; key = "T"; action = "CreateNewWindow"; }
        { mods = "Control"; key = "W"; action = "Quit"; }
        {
          mods = "Control";
          key = "Tab";
          command = {
            program = "hyprctl";
            args = [ "dispatch" "changegroupactive" ];
          };
        }
      ];
    };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Alacritty";
    };
  };
}
