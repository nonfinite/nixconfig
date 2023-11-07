{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  networking.networkmanager.enable = true;

  # hyprland uses kitty as the default terminal, so we must ensure it's installed
  environment.systemPackages = with pkgs; [
    kitty
  ];
}
