{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow it to keep everything
      ".local/share/JetBrains"
      ".config/JetBrains"
    ];
  };
}
