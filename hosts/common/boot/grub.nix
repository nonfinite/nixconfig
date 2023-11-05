{ device ? "nodev", ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      device = device;
      efiSupport = true;
    };
  };
}
