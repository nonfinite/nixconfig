{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.exfat
  ];
}
