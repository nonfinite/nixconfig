{ pkgs, ... }:
{
  imports = [
    ./codium.nix
    ./firefox.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}
