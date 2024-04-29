# Default lists all recipes
default:
  just --list

build-iso:
    cd /home/systemboss/nix-auto-install/install/auto
    nix-build

copy-iso:
    scp /home/systemboss/nix-auto-install/install/auto/result/iso/nixos-23.11.6621.dd37924974b9-x86_64-linux.iso systemboss@172.30.100.76:/tmp/nixos-23.11-auto-install.iso