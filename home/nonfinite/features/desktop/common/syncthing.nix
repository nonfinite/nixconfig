{ pkgs, ... }:
{
  home.packages = [
    pkgs.syncthingtray-minimal
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    files = [
      ".config/syncthingtray.ini"
    ];
  };

  exec-once.commands = [
    "syncthingtray"
  ];
}
