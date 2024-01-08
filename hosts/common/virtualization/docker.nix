{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/docker"
    ];
  };
}
