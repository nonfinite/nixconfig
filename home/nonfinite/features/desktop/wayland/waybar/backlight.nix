{ drawer, slider }:
{
  module = "group/backlight";

  settings = {
    "group/backlight" = {
      orientation = "inherit";
      drawer =
        if drawer then {
          transition-duration = 300;
          transition-left-to-right = true;
        } else null;
      modules =
        if slider then [
          "backlight"
          "backlight/slider"
        ] else [ "backlight" ];
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
