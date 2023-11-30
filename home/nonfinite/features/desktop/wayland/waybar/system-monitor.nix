{
  module = "group/system-monitor";
  settings = {
    "group/system-monitor" = {
      orientation = "inherit";
      modules = [
        "cpu"
        "memory"
      ];
    };

    "cpu" = {
      interval = 1;
      on-click = "gnome-system-monitor";
      format = "{icon}";
      format-icons = [
        "<span color='#69ff94'>▁</span>" #green
        "<span color='#2aa9ff'>▂</span>" #blue
        "<span color='#f8f8f2'>▃</span>" #white
        "<span color='#f8f8f2'>▄</span>" #white
        "<span color='#ffffa5'>▅</span>" #yellow
        "<span color='#ffffa5'>▆</span>" #yellow
        "<span color='#ff9977'>▇</span>" #orange
        "<span color='#dd532e'>█</span>" #red
      ];
    };

    "memory" = {
      interval = 30;
      on-click = "gnome-system-monitor";
      format = "{used:0.1f}/{total:0.0f}G ";
    };
  };
}
