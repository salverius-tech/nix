#!/usr/bin/env bash

set -e

if [ "$EUID" -ne 0 ]; then
    # If not, re-execute the script with sudo
    echo "This script requires root privileges. Elevating..."
    sudo bash "$0" "$@"
    exit $?
fi

# Check if the envsubst is installed
if ! nix-env -q envsubst >/dev/null 2>&1; then
    nix-env -iA nixos.envsubst
fi

DEVICE="/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0"
if [ ! -b "$DEVICE" ]; then
  echo "ERROR: The default disk $DEVICE is missing!"
  exit 1;
fi

# List partitions on the device
PARTITIONS=$(lsblk "$DEVICE" --output NAME --noheadings --raw | wc -l)

# Check if partitions exist
if [ "$PARTITIONS" != 1 ]; then
    echo "Looks like the disk partitions are already setup, skipping this step!"
else
    parted $DEVICE -- mklabel msdos
    parted $DEVICE -- mkpart primary 1MB -8GB
    parted $DEVICE -- mkpart primary linux-swap -8GB 100%
    
    mkfs.ext4 -L nixos $DEVICE-part1
    mkswap -L swap $DEVICE-part2
    swapon /dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-part2
    mount /dev/disk/by-label/nixos /mnt
fi

nixos-generate-config --root /mnt

HASHED_PW_FILE="$HOME/.hashed_pw"

# Check if the hashed password file exists
if [ -f "$HASHED_PW_FILE" ]; then
    # Read the hashed password from the file
    HASHED_PASSWORD=$(cat "$HASHED_PW_FILE")
else
    # Check if $PW is set
    if [ -z "${PW}" ]; then
        # Prompt the user for a value
        read -p "Enter user password: " -sr PW
        echo
    fi

    # Generate the hashed password
    HASHED_PASSWORD=$(mkpasswd "$PW")
    

    # Store the hashed password in the file
    echo "$HASHED_PASSWORD" > "$HASHED_PW_FILE"
fi
export HASHED_PASSWORD

# download the configuation.nix template
curl -s "https://raw.githubusercontent.com/salverius-tech/nix/main/sites/homelab/hosts/nxs-nix-test/configuration.nix" > configuration.nix
curl -s "https://raw.githubusercontent.com/salverius-tech/nix/main/sites/homelab/hosts/nxs-nix-test/hardware-configuration.nix" > hardware-configuration.nix
curl -s "https://raw.githubusercontent.com/salverius-tech/nix/main/common/starship.nix" > starship.nix

# process the template
envsubst "${HASHED_PASSWORD}" < configuration.nix > /mnt/etc/nixos/configuration.nix

nixos-install

# Check if the directory exists
if [ -d "/mnt/home/anvil" ]; then
    touch /mnt/home/anvil/.zshrc
    chown 1000:100 /mnt/home/anvil/.zshrc
fi

while true; do
    read -p "Do you want to reboot now? (y/n) " yn
    case $yn in
        [Yy]* )
            reboot
            break;;
        [Nn]* )
            exit;;
        * )
            echo "Please answer y or n.";;
    esac
done
