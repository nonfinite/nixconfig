{ ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nonfinite" ];
  };

  home-manager.users.nonfinite.home = {
    file.".config/autostart/1password.desktop".text = ''
      [Desktop Entry]
      Name=1Password
      Exec=1password %U
      Terminal=false
      Type=Application
      Icon=1password
      StartupWMClass=1Password
      MimeType=x-scheme-handler/onepassword;
    '';

    persistence."/nix/persist/home/nonfinite" = {
      allowOther = true;
      directories = [
        # for now just allow it to keep everything
        ".config/1Password"
      ];
    };
  };
}
