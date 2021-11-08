{ pkgs ? import <nixpkgs> {} }:
let
  sops-nix-commit = "2e86e1698d53e5bd71d9de5f8b7e8f2f5458633c";
  sops-nix = builtins.fetchTarball {
    url = "https://github.com/Mic92/sops-nix/archive/${sops-nix-commit}.tar.gz";
    sha256 = "sha256:0g5xv27s1sx87xxz2ipfi21sqksfmbvx9yn2i0lqb419aqqyks50";
  };
  deploy = import ./default.nix;
in
pkgs.mkShell {
  sopsPGPKeyDirs = [
    "./keys/hosts"
    "./keys/users"
  ];

  nativeBuildInputs = [
    (pkgs.callPackage sops-nix {}).sops-import-keys-hook
  ];

  buildInputs = [
    pkgs.sops
    (pkgs.writeShellScriptBin "deploy-fb" "${deploy.fb}")
    (pkgs.writeShellScriptBin "deploy-car" "${deploy.car}")
    (pkgs.writeShellScriptBin "deploy-cadr" "${deploy.cadr}")
    (pkgs.writeShellScriptBin "deploy-all" "${deploy.all}")

    # keep this line if you use bash
    pkgs.bashInteractive
  ];
}
