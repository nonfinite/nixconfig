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
      ".local/share/JetBrains"
      ".config/JetBrains"
    ];
  };

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    # Center popup windows such as the action search window
    "center,title:^win0$,class:jetbrains-idea"
  ];
}
