{ ... }:
{
  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".local/share/Steam"
    ];
  };
}
