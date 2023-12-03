{
  # https://i3wm.org/docs/userguide.html#for_window
  # https://i3wm.org/docs/userguide.html#command_criteria
  # https://i3wm.org/docs/userguide.html#list_of_commands
  wayland.windowManager.sway.config.window.commands = [
    {
      command = "move window to workspace 󰍩";
      criteria = {
        app_id = "org.telegram.desktop";
      };
    }
    {
      command = "move window to workspace 󰍩";
      criteria = {
        app_id = "discord";
      };
    }
    {
      command = "floating enable; move position mouse; move down 32 px; focus floating";
      criteria = {
        app_id = "syncthingtray";
      };
    }
  ];
}
