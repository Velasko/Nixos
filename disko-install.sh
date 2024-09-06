sudo nix --experimental-features "nix-command flakes" \
run 'github:nix-community/disko#disko-install' -- \
	--write-efi-boot-entries \
	--flake 'github:velasko/nixos#nixos' \
	--disk main /dev/vda

