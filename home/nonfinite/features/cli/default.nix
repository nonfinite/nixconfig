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

  programs = {
    bash.enable = true;
    direnv.enable = true;
  };

  home.shellAliases = {
    da = "direnv allow";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".local/share/direnv"
    ];
  };
}
