#!/usr/bin/env bash

REPO_PATH=$HOME/Nixos

git clone -b disko https://github.com/velasko/nixos $REPO_PATH

# Generate hw-config file:
# nixos-generate-config --no-filesystems --root /mnt
sudo rm -f /etc/nixos/* # Directory must be clean to generate it
sudo nixos-generate-config --no-filesystems


MACHINE="unknown"
case $(sudo cat /sys/class/dmi/id/product_uuid) in
	"03ff0210-04e0-05f0-2406-800700080009")
		MACHINE="desktop"
		;;
	"2bc99f80-f604-11ee-8226-ebae00cc1200")
		MACHINE="book4"
		;;
esac

if [[ $(cat /proc/cpuinfo | grep hypervisor | wc -l) -gt 0 ]]; then
	MACHINE="virtualized"
fi

if [[ $MACHINE == "unknown" ]]; then
	echo "Could not detect which machine configuration to run. Please select one:"
	MACHINE=$(ls -1 $REPO_PATH/system/machines | gum choose)
fi

DISK="zfs"
if [[ $(cat $REPO_PATH/system/machines/${MACHINE}/hardware-configuration.nix | grep ext4.nix | wc -l) -tg 0 ]]; then
	DISK="ext4"
fi

gum confirm --default=false "This process will erase the data on ALL discs. Do you want to continue ?"


# sudo nix run github:nix-community/disko \
#     --extra-experimental-features "nix-command flakes" \
# 	--no-write-lock-file \
# 	-- \
# 	--mode zap_create_mount \
# 	"$REPO_PATH/system/modules/disko/$DISK.nix"

echo "$REPO_PATH/system/modules/disko/$DISK.nix"

echo "$REPO_PATH#$MACHINE.main"
# sudo nixos-install \
# 	--no-root-passwd \
# 	--no-channel-copy \
# 	--no-write-lock-file \
# 	--flake "$REPO_PATH#$MACHINE.main" \
# 	--root /mnt
