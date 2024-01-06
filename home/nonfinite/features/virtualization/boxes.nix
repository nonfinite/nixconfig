{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.gnome-boxes
  ];

  dconf.settings = {
    "org/gnome/boxes" = {
      first-run = false;
    };
  };


  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/gnome-boxes"
      ".local/share/gnome-boxes"
    ];
  };
}
