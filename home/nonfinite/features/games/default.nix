{ ... }:
{
  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".local/share/Steam"

      # Unity games tend to save here:
      ".config/unity3d"
    ];
  };
}
