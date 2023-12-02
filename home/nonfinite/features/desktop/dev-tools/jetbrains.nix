{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  home.shellAliases = {
    idea = "idea-ultimate &> /tmp/log/idea-ultimate";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow it to keep everything
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
    ];
  };

  # wayland.windowManager.hyprland.settings.windowrulev2 = [
  #   # Center popup windows such as the action search window
  #   "center,title:^win0$,class:jetbrains-idea"
  # ];
}
