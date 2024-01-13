{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "podman";
  };

  environment.shellAliases = {
    pc = "podman-compose";
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/containers"
    ];
  };
}
