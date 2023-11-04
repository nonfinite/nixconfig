{ pkgs, ... }:
{
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
    ];
    userSettings = {
      "update.mode" = "none";
      "security.workspace.trust.enabled" = false;

      "editor.fontFamily" = "'DejaVu Sans Mono Nerd Font', monospace";
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "all";
      "workbench.colorTheme" = "Default Dark Modern";

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
  };
}
