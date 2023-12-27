{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains-toolbox
  ];

  home.sessionPath = [
    "/home/nonfinite/.local/share/JetBrains/Toolbox/scripts"
  ];

  home.shellAliases = {
    rr = "rustrover";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".java/.userPrefs/jetbrains"
    ];
  };
}
