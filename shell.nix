# A shell with flake-enabled nix
{ pkgs ? let
    lock =
      if builtins.pathExists ./flake.lock
      then (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked
      else { rev = "864814c092a7b9965104ce0b6639dc986350050b"; narHash = "sha256-HFjjlZY62hUdWYjnyRdAy7OoNChpC0zqiqVXAIcQFCw="; };
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
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
