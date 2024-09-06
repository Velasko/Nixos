{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		xremap.url = "github:xremap/nix-flake";
		stylix.url = "github:danth/stylix";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
		dotfiles = {
			flake = false;
			url = "github:velasko/dotfiles/nixos";
        };
	};

	outputs = { nixpkgs, home-manager, stylix, ... } @inputs :
	let
		inherit (nixpkgs.lib.lists) foldl forEach;
		pkgs = import nixpkgs {
			config.allowUnfree = true;
			inherit system;
		};

		system = "x86_64-linux";
		machines = ["nixos" "work"];
		username = "velasco";
		default_hostname = builtins.elemAt machines 0;
	in {
		nixosConfigurations = foldl (a: b: a // b) { } (
			forEach machines (hostname: {
				"${hostname}" = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs username hostname stylix; };
					modules = [
						./system/hardware-configuration.nix
						./system/configuration.nix
						./home/base.nix
					];
					inherit system;
				};
			})
		);
	};
}
