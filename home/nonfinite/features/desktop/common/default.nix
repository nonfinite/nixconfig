{ pkgs, ... }:
{
  imports = [
    ./codium.nix
    ./discord.nix
    ./firefox.nix
    ./telegram.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}
