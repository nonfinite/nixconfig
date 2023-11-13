{ pkgs, ... }:
{
  imports = [
    ./nix.nix
  ];

  home.packages = with pkgs; [
    fend # calculator
    inotify-tools # watch directories for changes
    lsof # list files of process
  ];

  programs.bash.enable = true;
}
