{
  module = "group/backlight";

  settings = {
    "group/backlight" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 300;
        transition-left-to-right = true;
      };
      modules = [
        "backlight"
        "backlight/slider"
      ];
    };

    "backlight" = {
      device = "intel_backlight";
      format = "{icon} {percent}%";
      format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
    };

    "backlight/slider" = {
      device = "intel_backlight";
      min = 5;
      max = 100;
    };
  };
}
