{ drawer, slider }:
{
  module = "group/audio";
  settings = {
    "group/audio" = {
      orientation = "inherit";
      drawer =
        if drawer then {
          transition-duration = 300;
          transition-left-to-right = true;
        } else null;
      modules =
        if slider then [
          "pulseaudio"
          "pulseaudio/slider"
        ] else [ "pulseaudio" ];
      device = "intel_backlight";
      format = "{icon} {percent}%";
      format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
    };

    "pulseaudio" = {
      format = "{icon} {volume}";
      format-muted = "󰖁";
      tooltip-format = "{icon} {desc} // {volume}%";
      scroll-step = 1;
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "󰕿" "󰖀" "󰕾" ];
      };
    };

    "pulseaudio/slider" = {
      min = 0;
      max = 100;
    };
  };
}
