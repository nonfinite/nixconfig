{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_20
  ];

  home.sessionPath = [ "$HOME/.cache/corepack" ];
  home.shellAliases = {
    corepack-enable = "rm $HOME/.cache/corepack/* && corepack enable --install-directory $HOME/.cache/corepack";
    nr = "pnpm run";
  };

  home.persistence."/nix/persist/home/nonfinite" = {
    directories = [
      ".cache/corepack"
      ".cache/node"
    ];
  };
}
