{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.nonfinite = {
      # These are found in .mozilla/firefox/<profile>/prefs.js
      id = 0;
      isDefault = true;
      path = "nonfinite";
      settings = {
        "browser.disableResetPrompt" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".cache/mozilla/firefox/nonfinite"
      ".mozilla/firefox/nonfinite"
    ];
  };
}
