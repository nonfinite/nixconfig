{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wakeonlan
  ];

  home.shellAliases = {
    wake-mizuna = "wakeonlan 5c:ed:8c:e8:ec:ee";
  };
}
