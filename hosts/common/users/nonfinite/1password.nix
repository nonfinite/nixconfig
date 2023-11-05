{ ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nonfinite" ];
  };

  home-manager.users.nonfinite.home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      # for now just allow it to keep everything
      ".config/1Password"
    ];
  };
}
