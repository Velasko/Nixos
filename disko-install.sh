DISKPATH="/tmp/disko.nix"

# Generate hw-config file:
# nixos-generate-config --no-filesystems --root /mnt

curl https://raw.githubusercontent.com/Velasko/Nixos/main/nix-clear.sh | bash -


curl https://raw.githubusercontent.com/Velasko/Nixos/main/system/disko/disko-config.nix -o $DISKPATH
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $DISKPATH

sudo nixos-install \
	--no-root-passwd \
	--no-channel-copy \
	--no-write-lock-file \
	--flake 'github:velasko/nixos#nixos' \
	--root /mnt

# sudo nixos-enter --root /mnt -c 'passwd velasco'

# sudo nix --experimental-features "nix-command flakes" \
# run 'github:nix-community/disko#disko-install' -- \
# 	--write-efi-boot-entries \
# 	--flake 'github:velasko/nixos#nixos' \
# 	--disk main /dev/vda
