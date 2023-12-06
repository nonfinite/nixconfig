{
  programs.bash = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Alacritty";
    };
  };
}
