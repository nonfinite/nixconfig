{
  # See https://unicodes.jessetane.com/󰤨 for useful icons
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
          "battery"
          "network"
        ];

        "clock" = {
          format = "{:%I:%M %F}";
        };
        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };
        "network" = {
          format-wifi = "{icon} {essid}";
          format-icons = ["󰤫 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
          format-ethernet = "󱘖  Wired";
          tooltip-format = "󱘖  {ipaddr} {icon} {signalStrength}%\n {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-linked = "󱘖  {ifname} (No IP)";
          format-disconnected = "  Disconnected";
          format-alt = "󰤨  {signalStrength}%";
          interval = 5;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };
      };
    };
  };
}
