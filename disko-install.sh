DISKPATH="/tmp/disko.nix"

# Generate hw-config file:
rm -f /etc/nixos/*
# nixos-generate-config --no-filesystems --root /mnt
nixos-generate-config --no-filesystems

curl https://raw.githubusercontent.com/Velasko/Nixos/main/nix-clear.sh | bash -

if [[ $(cat /proc/cpuinfo) != *"hypervisor"* || $(cat /etc/machine-id) == "db8e3934eee544689f3e2460bef7a0d8" ]]; then
	disko_url="zfs"
else
	disko_url="ext4"
fi

curl "https://raw.githubusercontent.com/Velasko/Nixos/main/system/disko/${disko_url}.nix" -o $DISKPATH

if [[ $(cat /proc/cpuinfo) != *"hypervisor"* ]]; then
	sed -i -e 's/sda/vda/g' $DISKPATH
fi

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
	--mode disko $DISKPATH

sudo nixos-install \
	--no-root-passwd \
	--no-channel-copy \
	--no-write-lock-file \
	--flake 'github:velasko/nixos#minimal' \
	--root /mnt

sudo nixos-enter --root /mnt -c 'passwd velasco'


