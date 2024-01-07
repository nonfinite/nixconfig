# based on https://nixos.wiki/wiki/Remote_LUKS_Unlocking
# networkKernelModule = lspci -v | grep -iA8 'network\|ethernet'
{ networkKernelModule }:
let
  pk = import ../../../pub-keys.nix;
in
{
  boot.initrd.network.enable = true;
  boot.initrd.availableKernelModules = [
    networkKernelModule
  ];
  boot.initrd.network.ssh = {
    enable = true;
    port = 23;
    shell = "/bin/cryptsetup-askpass";
    authorizedKeys = [ pk.users.nonfinite ];
    hostKeys = [
      "/etc/secrets/initrd/ssh_host_ed25519_key"
    ];
  };
  boot.kernelParams = [ "ip=dhcp" ];

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/secrets"
    ];
  };
}
