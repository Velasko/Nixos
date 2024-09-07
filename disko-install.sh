DISKPATH="/tmp/disko.nix"

curl https://raw.githubusercontent.com/Velasko/Nixos/main/system/disko/disko-config.nix > $DISKPATH

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $DISKPATH
sudo nixos-install --flake 'github:velasko/nixos#nixos' --root /mnt

# sudo nix --experimental-features "nix-command flakes" \
# run 'github:nix-community/disko#disko-install' -- \
# 	--write-efi-boot-entries \
# 	--flake 'github:velasko/nixos#nixos' \
# 	--disk main /dev/vda
