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

  home.file.".config/autostart/telegram-desktop.desktop".text = ''
    [Desktop Entry]
    Name=Telegram Desktop
    TryExec=telegram-desktop
    Exec=telegram-desktop -- %u
    Icon=telegram
    Terminal=false
    StartupWMClass=TelegramDesktop
    Type=Application
    Categories=Chat;Network;InstantMessaging;Qt;
    MimeType=x-scheme-handler/tg;
    Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
    DBusActivatable=true
    SingleMainWindow=true
    X-GNOME-UsesNotifications=true
    X-GNOME-SingleWindow=true
  '';
}
