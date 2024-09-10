DISKPATH="/tmp/disko.nix"

# Generate hw-config file:
# nixos-generate-config --no-filesystems --root /mnt
sudo rm -f /etc/nixos/* # Directory must be clean to generate it
sudo nixos-generate-config --no-filesystems

# Clean possible previous builds
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

# Preping repo for install
NIX_REPO="/tmp/Nixos"
rm -rf $NIX_REPO
nix-shell -p git --run "git clone https://github.com/Velasko/Nixos ${NIX_REPO}"
rm -rf $NIX_REPO/flake.lock $NIX_REPO/.git
cp /etc/nixos/hardware-configuration.nix $NIX_REPO/system/unknown/hardware-configuration.nix # Make build pure

sudo nixos-install \
	--no-root-passwd \
	--no-channel-copy \
	--no-write-lock-file \
	--flake $NIX_REPO#minimal \
	--root /mnt

sudo nixos-enter --root /mnt -c 'passwd velasco'


