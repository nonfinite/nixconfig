{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (netdata.override { withCloud = true; })
  ];

  services.netdata = {
    enable = true;
    claimTokenFile = config.age.secrets.netdata-claim-token;
  };
}
