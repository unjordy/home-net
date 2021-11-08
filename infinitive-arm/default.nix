{ config, lib, pkgs, ... }:

let
  infinitive-arm-bin = pkgs.callPackage ./infinitive-arm-bin.nix {};
  internal-port = 3000;
  serial = "/dev/ttyUSB0";
in
{
  systemd.services.infinitive = {
    description = "Infinitive SAM server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = config.users.users.infinitive.name;
      Group = config.users.groups.infinitive.name;
      SupplementaryGroups = [
        "dialout"
      ];
      ExecStart = "${infinitive-arm-bin}/bin/infinitive -httpport ${toString internal-port} -serial ${serial}";
      Restart = "on-failure";
      RestartSec = 30;
    };
  };

  users.users.infinitive = {
    group = "infinitive";
    description = "Infinitive user";
    isSystemUser = true;
    createHome = false;
  };

  users.groups.infinitive = {};

  services.nginx = {
    enable = true;
    virtualHosts."_" = {
      default = true;
      locations."/api/ws" = {
        proxyPass = "http://127.0.0.1:${toString internal-port}/api/ws";
        proxyWebsockets = true;
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString internal-port}";
        proxyWebsockets = true;
        basicAuthFile = config.sops.secrets.infinitive-htpasswd.path;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];

  sops.secrets.infinitive-htpasswd = {
    sopsFile = ../secrets/infinitive.yaml;
    owner = config.services.nginx.user;
  };
}
