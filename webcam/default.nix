{ config, lib, pkgs, ... }:

{
  services.mjpg-streamer = {
    enable = true;
    inputPlugin = "input_uvc.so -r 1280x720 -f 30";
  };

  networking.firewall.allowedTCPPorts = [ 5050 ];
}
