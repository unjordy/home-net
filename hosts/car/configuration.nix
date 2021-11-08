{ config, lib, pkgs, ... }:

{
  imports = [
    ../../secrets
    ../../hardware/rock64.nix
    ../../hardware/wifi/wpa.nix
    ../../infinitive-arm
  ];

  networking.hostName = "car";
}
