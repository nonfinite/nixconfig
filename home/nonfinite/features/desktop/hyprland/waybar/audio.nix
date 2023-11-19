{
  module = "group/audio";
  settings = {
    "group/audio" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 300;
        transition-left-to-right = true;
      };
      modules = [
        "pulseaudio"
        "pulseaudio/slider"
      ];
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
