let
  krops = builtins.fetchGit {
    url = "https://cgit.krebsco.de/krops/";
    ref = "refs/tags/v1.25.0";
  };
  lib = import "${krops}/lib";
  pkgs = import "${krops}/pkgs" {};

  deploy = name: target: extraSources: pkgs.krops.writeDeploy "deploy-${name}" {
    inherit target;
    source = lib.evalSource [
      ({
        hosts.file = toString ./hosts;
        hardware.file = toString ./hardware;
        keys.file = toString ./keys;
        nixos-config.symlink = "hosts/${name}/configuration.nix";
        nixpkgs.git = {
          ref = "origin/nixos-21.05";
          url = "https://github.com/NixOS/nixpkgs";
        };
      } // extraSources)
    ];
  };

  deploy-arm = name: target: extraSources: pkgs.krops.writeDeploy "deploy-${name}" {
    inherit target;
    crossDeploy = true;
    force = true;
    source = lib.evalSource [
      ({
        hosts.file = toString ./hosts;
        hardware.file = toString ./hardware;
        keys.file = toString ./keys;
        nixos-config.symlink = "hosts/${name}/configuration.nix";
        nixpkgs.git = {
          ref = "2deb07f3ac4eeb5de1c12c4ba2911a2eb1f6ed61";
          url = "https://github.com/NixOS/nixpkgs";
          shallow = true;
        };
      } // extraSources)
    ];
  };

  fb = deploy "fb" "root@fb" {
    octoprint.file = toString ./octoprint;
    webcam.file = toString ./webcam;
    git-repo.file = toString ./git-repo;
    home-assistant.file = toString ./home-assistant;
  };
  car = deploy-arm "car" "root@car" {
    secrets.file = toString ./secrets;
    infinitive-arm.file = toString ./infinitive-arm;
  };
  cadr = deploy-arm "cadr" "root@cadr" {
    secrets.file = toString ./secrets;
    infinitive-arm.file = toString ./infinitive-arm;
  };
in
{
  inherit fb car cadr;
  all = pkgs.writeScript "deploy-all"
    (lib.concatStringsSep "\n" [ fb car cadr ]);
}
