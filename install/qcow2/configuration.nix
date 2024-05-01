{ config, lib, pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_5_15;

  users.users = {
    tarn = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "";
    };
  };

  environment.systemPackages = with pkgs; [
    python310
  ];

  # system.stateVersion = "23.05";
}