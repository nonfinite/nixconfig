{
  virtualisation.waydroid.enable = true;

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/waydroid"
    ];
  };
}
