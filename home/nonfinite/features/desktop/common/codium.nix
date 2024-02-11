{ pkgs, ... }:
{
  home.packages = with pkgs; [
    caddy # required for vscode-extensions.matthewpi.caddyfile-support
    egl-wayland
    libGL
    libglvnd
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.matthewpi.caddyfile-support
    ];
    keybindings = [
      {
        key = "shift+alt+l";
        command = "workbench.files.action.showActiveFileInExplorer";
      }
      {
        key = "ctrl+e ctrl+f";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
      {
        key = "ctrl+o";
        command = "file-browser.open";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "security.workspace.trust.enabled" = false;

      "editor.fontFamily" = "'DejaVu Sans Mono Nerd Font', monospace";
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "all";
      "explorer.confirmDelete" = false;
      "workbench.colorTheme" = "Default Dark Modern";
      "window.zoomLevel" = 1;
      "window.menuBarVisibility" = "classic";
      "window.titleBarStyle" = "custom";

      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
        };
      };
    };
  };

  home.shellAliases = {
    code = "codium";
    # launch code without wayland flags, as it can sometimes have issues with them: --enable-features=UseOzonePlatform --ozone-platform=wayland
    xcode = "NIXOS_OZONE_WL= codium";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    allowOther = true;
    directories = [
      ".config/VSCodium/Backups"
      ".config/VSCodium/User"
      ".config/VSCodium/Workspaces"
      ".vscode-oss"
    ];
    files = [
      ".config/VSCodium/Preferences"
    ];
  };
}
