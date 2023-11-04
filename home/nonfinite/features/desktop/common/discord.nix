{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow discord to keep everything
      ".config/discord"
    ];
  };
}
