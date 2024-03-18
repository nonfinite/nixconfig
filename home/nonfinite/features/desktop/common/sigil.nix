{ pkgs, ... }:
{
  home.packages = [ pkgs.sigil ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".local/share/sigil-ebook"
    ];
  };
}
