{ pkgs, ... }:
{
  home.packages = [
    # pkgs.discord
    pkgs.unstable.webcord
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".config/discord"
      ".config/WebCord"
    ];
  };

  exec-once.commands = [ "webcord" ];
}
