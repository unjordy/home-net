{ config, lib, pkgs, ... }:

{
  time.timeZone = "America/Los_Angeles";

  users = {
    mutableUsers = false;
    users.root = {
      initialHashedPassword = "";
      openssh.authorizedKeys.keyFiles = [
        ../keys/id_rsa.pub
      ];
    };
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "prohibit-password";
    };
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        userServices = true;
        hinfo = true;
      };
    };
    fstrim.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    git # Required by krops
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
}
