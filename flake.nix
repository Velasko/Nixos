{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		xremap.url = "github:xremap/nix-flake";
		stylix.url = "github:danth/stylix";
	};

	outputs = { nixpkgs, home-manager, stylix, ... } @inputs :
	let
		pkgs = nixpkgs.legacyPackages.${system};
		system = "x86_64-linux";
		hostname = "nixos";
		username = "velasco";
	in {
		devShells."${system}".default = pkgs.mkShell {
			nativeBuildInputs = with pkgs; [
				libgcc
			];
    };

		nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; inherit username; inherit hostname; };
			inherit system;
			modules = [
				./system/hardware-configuration.nix
				./system/configuration.nix
			];
		};

		homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
			extraSpecialArgs = { inherit inputs; inherit username; inherit hostname; };
			inherit pkgs;
			modules = [
			  stylix.homeManagerModules.stylix
			  ./home/home.nix
			];
		};
	};
}
