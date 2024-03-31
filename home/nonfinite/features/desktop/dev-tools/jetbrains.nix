{ pkgs, ... }:
{
  home.packages = [
    pkgs.unstable.jetbrains.idea-ultimate
    # pkgs.unstable.jetbrains.rust-rover
  ];

  home.shellAliases = {
    idea = "idea-ultimate . &> /dev/null & disown;";
    # rr = "rust-rover . &> /dev/null & disown;";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow it to keep everything
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".java/.userPrefs/jetbrains"
    ];
  };
}
