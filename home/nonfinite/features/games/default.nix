{ pkgs, ... }:
{
  home.packages = with pkgs; [ outfox ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".local/share/Steam"
      ".project-outfox"

      # Unity games tend to save here:
      ".config/unity3d"
    ];
  };
}
