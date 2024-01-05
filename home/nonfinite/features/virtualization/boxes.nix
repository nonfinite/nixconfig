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
      ".local/share/gnome-boxes"
    ];
  };
}
