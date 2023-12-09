{
  virtualisation.docker = {
    enable = true;
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/docker"
    ];
  };
}
