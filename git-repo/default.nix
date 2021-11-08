{ config, lib, pkgs, ... }:

let
  gitCreateRepo = pkgs.writeScriptBin "git-create-repo" ''
#!${pkgs.stdenv.shell}
sudo -u git bash -c "mkdir /home/git/$1.git && git init --bare /home/git/$1"
  '';
in
{
  users.users.git = {
    isSystemUser = true;
    home = "/home/git";
    createHome = true;
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keyFiles = [
      ../keys/id_rsa.pub
    ];
  };

  environment.systemPackages = [
    gitCreateRepo
  ];
}
