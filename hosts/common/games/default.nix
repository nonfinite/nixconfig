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
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };
}
