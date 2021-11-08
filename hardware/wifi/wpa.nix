{ config, lib, pkgs, ... }:

{
  networking.wireless = {
    enable = true;
  };

  sops.secrets."wpa_supplicant.conf" = {
    sopsFile = ../../secrets/wifi.yaml;
    path = "/etc/wpa_supplicant.conf";
  };
}
