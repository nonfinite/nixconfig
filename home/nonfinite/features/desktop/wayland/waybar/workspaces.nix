{ isHyprland }:
{
  module = if isHyprland then "hyprland/workspaces" else "custom/padd";
  settings = {
    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
    };
  };
}
