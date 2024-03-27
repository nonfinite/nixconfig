{
  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      { directory = ".local/share/waydroid"; method = "symlink"; }
    ];
  };
}
