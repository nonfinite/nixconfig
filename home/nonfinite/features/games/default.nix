{ ... }:
{
  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      {
        # Some games don't play well with bindfs
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
  };
}
