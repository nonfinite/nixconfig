{
  programs.git = {
    enable = true;
    userName = "Nonfinite";
    userEmail = "39420878+nonfinite@users.noreply.github.com";

    aliases = {
      co = "checkout";
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
