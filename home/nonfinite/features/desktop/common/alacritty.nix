{ ... }:
let
  themes = builtins.fetchGit {
    url = "https://github.com/alacritty/alacritty-theme.git";
    rev = "808b81b2e88884e8eca5d951b89f54983fa6c237";
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
      key_bindings = [
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
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Alacritty";
    };
  };
}
