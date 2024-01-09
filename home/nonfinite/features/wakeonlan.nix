{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wakeonlan
  ];

  home.shellAliases = {
    wake-fennel = "wakeonlan 5c:ed:8c:e8:ec:ee";
  };
}
