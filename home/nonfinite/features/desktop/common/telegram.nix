{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow telegram to keep everything
      ".local/share/TelegramDesktop"
    ];
  };

  exec-once.commands = [ "telegram-desktop" ];
}
