# based on https://nixos.wiki/wiki/Remote_LUKS_Unlocking
# networkKernelModule = lspci -v | grep -iA8 'network\|ethernet'
{ networkKernelModule, globals, ... }:
let
  pk = globals.pubKeys;
in
{
  boot.initrd.systemd.enable = true;
  boot.initrd.network.enable = true;
  boot.initrd.availableKernelModules = [
    networkKernelModule
  ];

  boot.initrd.network.ssh = {
    enable = true;
    port = 23;
    authorizedKeys = [ pk.users.nonfinite ];
    hostKeys = [
      "/etc/secrets/initrd/ssh_host_ed25519_key"
    ];
  };
  boot.initrd.systemd.users.root.shell = "/bin/systemd-tty-ask-password-agent";
  boot.kernelParams = [ "ip=dhcp" ];

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/secrets"
    ];
  };
}
