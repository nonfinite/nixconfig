{ pkgs, ... }:
{
  home.packages = with pkgs; [
    remmina
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/remmina"
      ".local/share/remmina"
    ];
  };
}
