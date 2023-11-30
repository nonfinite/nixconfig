{ config, ... }:
let
  customPad = {
    format = " ";
    interval = "once";
    tooltip = false;
  };
  audio = import ./audio.nix { drawer = false; slider = false; };
  backlight = import ./backlight.nix { drawer = false; slider = false; };
  workspaces = import ./workspaces.nix { isHyprland = config.wayland.windowManager.hyprland.enable; };
  system-monitor = import ./system-monitor.nix;
in
{
  # See https://unicodes.jessetane.com/󰤨 for useful icons
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        modules-left = [
          "custom/padd"

          "custom/l_end"
          workspaces.module
          "custom/r_end"

          "custom/padd"

          "custom/l_end"
          "wlr/taskbar"
          "custom/r_end"
        ];

        modules-center = [
        ];

        modules-right = [
          "custom/l_end"
          "tray"
          "idle_inhibitor"
          "custom/r_end"

          "custom/padd"

          "custom/l_end"
          system-monitor.module
          "custom/r_end"

          "custom/padd"

          "custom/l_end"
          "gamemode"
          audio.module
          "network"
          backlight.module
          "battery"
          "clock"
          "custom/r_end"

          "custom/padd"
        ];

        "tray" = {
          icon-size = 18;
          spacing = 5;
        };

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
        "gamemode" = {
          format = "{glyph}";
          format-alt = "{glyph}";
          glyph = "";
          hide-not-running = true;
          use-icon = true;
          icon-name = "input-gaming-symbolic";
          icon-spacing = 4;
          icon-size = 18;
          tooltip = true;
          tooltip-format = "Games running: {count}";
        };
        "network" = {
          format-wifi = "{icon} {essid}";
          format-icons = [ "󰤫" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = "󱘖 Wired";
          tooltip-format = "󱘖 {ipaddr} {icon} {signalStrength}%\n {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = " Disconnected";
          format-alt = "󰤨 {signalStrength}%";
          interval = 5;
        };
        "bluetooth" = {
          format = "";
          format-disabled = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
            tooltip-format-activated = "idle disabled";
            tooltip-format-deactivated = "idle allowed";
          };
        };

        # Modules for padding
        "custom/padd" = customPad;
        "custom/l_end" = customPad;
        "custom/r_end" = customPad;
      } // audio.settings // backlight.settings // workspaces.settings // system-monitor.settings;
    };
  };
}
