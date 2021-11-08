{ config, lib, pkgs, ... }:

{
  imports = let
  sops-nix-commit = "2e86e1698d53e5bd71d9de5f8b7e8f2f5458633c";
  in [
    "${builtins.fetchTarball {
      url = "https://github.com/Mic92/sops-nix/archive/${sops-nix-commit}.tar.gz";
      sha256 = "sha256:0g5xv27s1sx87xxz2ipfi21sqksfmbvx9yn2i0lqb419aqqyks50";
    }}/modules/sops"
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
}
