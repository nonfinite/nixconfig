# Install with
# ln -s /home/deck/.config/home-manager/home.nix
{ config, pkgs, ... }:

{
  
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "24.05";

  home.packages = [];
  home.sessionVariables = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}