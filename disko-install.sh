DISKPATH="/tmp/disko.nix"

# Generate hw-config file:
sudo rm -f /etc/nixos/*
# nixos-generate-config --no-filesystems --root /mnt
sudo nixos-generate-config --no-filesystems

curl https://raw.githubusercontent.com/Velasko/Nixos/main/nix-clear.sh | bash -

if [[ $(cat /proc/cpuinfo) != *"hypervisor"* || $(cat /etc/machine-id) == "db8e3934eee544689f3e2460bef7a0d8" ]]; then
	disko_url="zfs"
else
	disko_url="ext4"
fi

curl "https://raw.githubusercontent.com/Velasko/Nixos/main/system/disko/${disko_url}.nix" -o $DISKPATH

if [[ $(cat /proc/cpuinfo) != *"hypervisor"* ]]; then
	sed -i -e 's/vda/nvme0n1/g' $DISKPATH
fi

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
	--mode disko $DISKPATH

rm -rf /tmp/Nixos
nix-shell -p git --run "git clone https://github.com/Velasko/Nixos /tmp/Nixos"
rm /tmp/Nixos/flake.lock /tmp/Nixos/.git

sudo nixos-install \
	--no-root-passwd \
	--no-channel-copy \
	--no-write-lock-file \
	--flake /tmp/Nixos#minimal \
	--root /mnt \
	--impure #For unknown systems with just generated configs

sudo nixos-enter --root /mnt -c 'passwd velasco'


