{
  hardware.opengl.driSupport32Bit = true;
  programs.steam = {
    enable = true;
  };

  environment.variables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "2";
  };
}
