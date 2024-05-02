{ config, lib, pkgs, ... }: let
  # Import the secrets.nix file
  secrets = import ./.secrets;
in {
  imports = [
    #  <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ./base-config.nix
    ./hardware-configuration.nix
    ./packages.nix
  ];

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "nxs-nix-test";

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.qemuGuest.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
  system.autoUpgrade.enable = true;

}