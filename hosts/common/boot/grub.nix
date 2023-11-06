{ device ? "nodev", fontSize ? 20, pkgs, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      device = device;
      efiSupport = true;
      gfxmodeEfi = "2880x1800";
      font = "${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSansMono.ttf";
      fontSize = fontSize;
    };
  };
}
