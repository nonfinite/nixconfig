{
  virtualisation =
    {
      docker = {
        enable = true;
        enableOnBoot = true;
      };
      oci-containers.backend = "docker";
    };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/docker"
    ];
  };
}
