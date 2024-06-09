{ pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   rustup
  # ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".cargo"
      ".rustup"
    ];
  };
}
