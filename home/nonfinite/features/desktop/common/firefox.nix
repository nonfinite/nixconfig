{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.nonfinite = {
      # These are found in .mozilla/firefox/<profile>/prefs.js
      # See about:config for options
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
    profiles.vpn = {
      id = 1;
      isDefault = false;
      path = "vpn";
      settings = {
        "browser.disableResetPrompt" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;
        "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
        "network.proxy.backup.ssl" = "";
        "network.proxy.backup.ssl_port" = 0;
        "network.proxy.http" = "192.168.122.18";
        "network.proxy.http_port" = 8118;
        "network.proxy.share_proxy_settings" = true;
        "network.proxy.socks_remote_dns" = true;
        "network.proxy.ssl" = "192.168.122.18";
        "network.proxy.ssl_port" = 8118;
        "network.proxy.type" = 1;
      };
    };
    profiles.nojs = {
      id = 2;
      isDefault = false;
      path = "nojs";
      settings = {
        "browser.disableResetPrompt" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;
        "javascript.enabled" = false;
      };
    };
  };

  xdg.desktopEntries.firefox-vpn = {
    name = "FF VPN";
    genericName = "Web Browser (VPN)";
    exec = "firefox -P vpn %U";
    terminal = false;
    categories = [ "Application" "WebBrowser" ];
  };

  xdg.desktopEntries.firefox-nojs = {
    name = "FF No JS";
    genericName = "Web Browser (No JS)";
    exec = "firefox -P nojs %U";
    terminal = false;
    categories = [ "Application" "WebBrowser" ];
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".cache/mozilla/firefox/nonfinite"
      ".mozilla/firefox/nonfinite"
      ".mozilla/firefox/vpn"
      ".mozilla/firefox/nojs"
    ];
  };
}
