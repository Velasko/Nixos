sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake 'github:velasko/nixos#nixos' --disk main /dev/vda
