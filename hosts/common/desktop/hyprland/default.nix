{ pkgs, ... }:
{
  # programs.hyprland.enable = true;

  networking.networkmanager.enable = true;

  services = {
    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      audio.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  security.pam.services = {
    # required to allow swaylock to unlock
    swaylock = { };
  };

  # hyprland uses kitty as the default terminal, so we must ensure it's installed
  environment.systemPackages = with pkgs; [
    kitty
  ];
}
