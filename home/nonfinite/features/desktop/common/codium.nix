{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs; [
      vscode-extensions.bodil.file-browser
      vscode-extensions.jnoortheen.nix-ide
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
      ".config/VSCodium"
      ".vscode-oss"
    ];
  };
}
