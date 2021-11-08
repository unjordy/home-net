{ config, lib, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    package = pkgs.home-assistant.override {
      extraPackages = py: with py; [
        (pkgs.callPackage ./pytradfri.nix {
          inherit (py) buildPythonPackage pythonOlder aiocoap pytestCheckHook;
          dtlssocket = (pkgs.callPackage ./dtlssocket.nix {
            inherit (py) buildPythonPackage fetchPypi cython;
          });
        })
      ];
    };
    config = {
      default_config = {};
      homeassistant = {
        time_zone = "America/Los_Angeles";
      };
      scene = "!include scenes.yaml";
      automation = "!include automations.yaml";
      group = "!include groups.yaml";
      script = "!include scripts.yaml";
      met = {};
      tradfri = {};
    };
  };
}
