{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		xremap.url = "github:xremap/nix-flake";
		stylix.url = "github:danth/stylix";
		dotfiles = {
		  flake = false;
          url = "github:velasko/dotfiles/nixos";
        };
	};

	outputs = { nixpkgs, home-manager, stylix, ... } @inputs :
	let
		inherit (nixpkgs.lib.lists) foldl forEach;
		pkgs = nixpkgs.legacyPackages.${system};
		system = "x86_64-linux";
		machines = ["nixos" "work"];
		username = "velasco";
	in {
		nixosConfigurations = foldl (a: b: a // b) { } (
			forEach machines (hostname: {
				"${hostname}" = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs; inherit username; inherit hostname; };
					inherit system;
					modules = [
						./system/hardware-configuration.nix
						./system/configuration.nix
					];
				};
			})
		);

		homeConfigurations = foldl (a: b: a // b) { } (
			forEach machines (hostname: {
				"${hostname}" = home-manager.lib.homeManagerConfiguration {
					extraSpecialArgs = { inherit inputs; inherit username; inherit hostname; };
					inherit pkgs;
					modules = [
						stylix.homeManagerModules.stylix
						./home/base.nix
					];
				};
			})
		);
	};
}
