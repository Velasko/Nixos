DISKPATH="/tmp/disko.nix"

# Generate hw-config file:
# nixos-generate-config --no-filesystems --root /mnt

curl https://raw.githubusercontent.com/Velasko/Nixos/main/nix-clear.sh | bash -

if [[ $(cat /proc/cpuinfo) != *"hypervisor"* -o $(cat /etc/machine-id) == "db8e3934eee544689f3e2460bef7a0d8" ]]; then
	disko_url="zfs"
else
	disko_url="ext4"
fi

curl "https://raw.githubusercontent.com/Velasko/Nixos/main/system/disko/${disko_type}.nix" -o $DISKPATH

if [[ $(cat /proc/cpuinfo) != *"hypervisor"* ]]; then
	# replace sda for vda
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


