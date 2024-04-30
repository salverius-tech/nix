{ config, lib, pkgs, ... }:

{

  networking.useDHCP = lib.mkDefault true;

}