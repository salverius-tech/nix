{ config, pkgs, ... }: {

   boot.growPartition = true;
   boot.kernelParams = [ "console=ttyS0" ];
   boot.loader.grub.device = "/dev/vda";
   boot.loader.timeout = 0;
   
	 fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      autoResize = true;
    };

}