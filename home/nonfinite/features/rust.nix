{ ... }:
{
  # prefer to add rust via individual dev shells/flakes to control different versions
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
