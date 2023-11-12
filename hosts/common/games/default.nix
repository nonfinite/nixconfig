{
  imports = [
    ./steam.nix
  ];

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        inhibit_screensaver = 1;
      };
    };
  };
}
