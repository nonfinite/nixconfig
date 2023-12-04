# A shell with flake-enabled nix
{ pkgs ? let
    nixpkgs = fetchTarball (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
  in
  import nixpkgs
, ...
}:

pkgs.mkShell {
  NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
  nativeBuildInputs = with pkgs; [
    git
    nix
    nixpkgs-fmt
  ];
}
