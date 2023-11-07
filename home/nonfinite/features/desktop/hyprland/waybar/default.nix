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
          "wlr/taskbar"
        ];

        modules-center = [
        ];

        modules-right = [
          "bluetooth"
          "pulseaudio"
          "network"
          "battery"
          "clock"
        ];

        "wlr/taskbar" = {
          on-click = "activate";
          on-click-middle = "close";
        };

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
          format-icons = [ "󰤫 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
          format-ethernet = "󱘖  Wired";
          tooltip-format = "󱘖  {ipaddr} {icon} {signalStrength}%\n {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-linked = "󱘖  {ifname} (No IP)";
          format-disconnected = "  Disconnected";
          format-alt = "󰤨  {signalStrength}%";
          interval = 5;
        };
        "pulseaudio" = {
          format = "{icon} {volume}";
          format-muted = "🔇";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 1;
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [ " " " " " " ];
          };
        };
        "bluetooth" = {
          format = "";
          format-disabled = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };
      };
    };
  };
}
