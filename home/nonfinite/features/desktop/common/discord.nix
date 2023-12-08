{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow discord to keep everything
      ".config/discord"
    ];
  };

  home.file.".config/autostart/discord.desktop".text = ''
    [Desktop Entry]
    Exec=Discord
    Icon=discord
    MimeType=x-scheme-handler/discord
    Name=Discord
    Type=Application
  '';
}
