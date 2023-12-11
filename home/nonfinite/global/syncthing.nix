{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
  };

  home.packages = [
    pkgs.syncthingtray-minimal
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow it to keep everything
      ".config/syncthing"
    ];
    files = [
      ".config/syncthingtray.ini"
    ];
  };

  exec-once.commands = [
    "syncthingtray"
  ];
}
