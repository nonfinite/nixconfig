{
  services.fprintd.enable = true;

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/fprint"
    ];
  };
}
