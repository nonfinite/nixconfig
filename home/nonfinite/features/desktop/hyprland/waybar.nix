{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
        ];
        modules-right = [
          "clock"
        ];
        "clock" = {
          format = "{:%I:%M %F}";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };
      };
    };
  };
}
