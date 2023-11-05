{ pkgs, ... }:
{
  imports = [
    ./nix.nix
  ];

  home.packages = with pkgs; [
    lsof
  ];

  programs.bash.enable = true;
}
