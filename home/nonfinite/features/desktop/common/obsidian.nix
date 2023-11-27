{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".config/obsidian"
    ];
  };
}
