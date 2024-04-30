{ config, lib, pkgs, ... }:
{
  imports = [
    ./base-config.nix
    ./git.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./packages.nix
    ./starship.nix
  ];

  system.autoUpgrade.enable = true;

  time.timeZone = "America/Los_Angeles";

	networking.hostName = "nxs-nix-test";

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.qemuGuest.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";

}