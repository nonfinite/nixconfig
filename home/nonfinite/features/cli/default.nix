{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    fend # calculator
    htop # system monitor
    fatrace # watch all system file changes
    inotify-tools # watch directories for changes
    lsof # list files of process
  ];

  programs.bash.enable = true;
}
