{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ungoogled-chromium
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".config/chromium/Default/Preferences"
    ];
  };
}
