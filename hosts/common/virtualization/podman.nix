{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      dockerSocket.enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
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
