{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixpkgs-fmt
    rnix-lsp
  ];

  home.shellAliases = {
    code = "codium";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs; [
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
      "nix.serverPath" = "rnix-lsp";
    };
  };
}
