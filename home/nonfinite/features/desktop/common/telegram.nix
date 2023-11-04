{ pkgs, ... }:

let
  # This fixes telegram's display in Wayland
  telegram-desktop-xcb = pkgs.symlinkJoin {
    name = "telegram-desktop";
    paths = [ pkgs.telegram-desktop ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/telegram-desktop \
        --set QT_QPA_PLATFORM xcb
    '';
  };
in
{
  home.packages = [
    telegram-desktop-xcb
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow telegram to keep everything
      ".local/share/TelegramDesktop"
    ];
  };
}
