{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
