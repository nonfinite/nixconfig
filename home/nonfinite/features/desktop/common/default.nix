{ pkgs, ... }:
{
  imports = [
    ./codium.nix
    ./discord.nix
    ./firefox.nix
    ./pinta.nix
    ./telegram.nix
    ./vlc.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}