{ config, lib, pkgs, ... }:
{
  imports = [
    ./config.nix
  ];
  services.octoprint-custom = {
    enable = true;
    user = "octoprint";
    stateDir = "/var/lib/octoprint/octoprint";
    plugins = plugins: with plugins; [
      tplinksmartplug
      bedlevelvisualizer
      octopod
      crealitytemperature
      bltouch
      m73progress
      ender3v2tempfix
    ];
  };

  systemd.tmpfiles.rules = [
    "d '/var/lib/octoprint' - ${config.services.octoprint-custom.user} ${config.services.octoprint-custom.group} - -"
  ];

  systemd.services.octoprint.serviceConfig.SupplementaryGroups = [
    "tty"
    "dialout"
  ];

  networking.firewall.allowedTCPPorts = [ 5000 ];
}
