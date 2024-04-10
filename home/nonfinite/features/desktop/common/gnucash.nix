{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    gnucash
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/gnucash"
      ".local/share/gnucash"
    ];
  };

  dconf.settings = {
    "org/gnucash/GnuCash/dialogs/tip-of-the-day" = {
      show-at-startup = false;
    };
    "org/gnucash/GnuCash/dialogs/new-user" = {
      first-startup = false;
    };
    "org/gnucash/GnuCash/dialogs/open-save" = {
      last-path = "/home/nonfinite/Documents/Finances";
    };
    "org/gnucash/GnuCash/history" = {
      file0 = "/home/nonfinite/Documents/Finances/finances.gnucash";
    };
  };
}
