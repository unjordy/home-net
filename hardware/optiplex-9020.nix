{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
    interfaces.wlp2s0.useDHCP = true;

    wireless.interfaces = [ "wlp2s0" ];
  };
}
