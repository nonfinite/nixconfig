{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ungoogled-chromium
  ];

  home.persistence."/nix/persist/home/nonfinite" = {
    files = [
      ".config/chromium/Default/Preferences"
    ];
  };
}
