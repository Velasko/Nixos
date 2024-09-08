{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
		dotfiles = {
			flake = false;
			url = "github:velasko/dotfiles/nixos";
        };
		github-keys = {
			flake = false;
			url = "https://github.com/velasko.keys";
		};
		machine-id = {
			flake = false;
			url = "path:/etc/machine-id";
		};
		# curr-env-id = {
		# 	flake = false;
		# 	url = "path:/etc/nixenv";
		# };
	};

	outputs = { nixpkgs, home-manager, stylix, ... } @inputs :
	let
		inherit (nixpkgs.lib.lists) foldl forEach;
		inherit (nixpkgs.lib.strings) concatStrings splitString;

		pkgs = import nixpkgs {
			config.allowUnfree = true;
			inherit platform;
		};

		platform = pkgs.config.nixpkgs.hostPlatform;
		machines = {
			samsung = "samsung-book4";
			db8e3934eee544689f3e2460bef7a0d8 = "virtualized";
			f9e173a52ff64f2b8fee83bbc966ea8c = "virtualized";
		};
		machine = machines."${concatStrings (splitString "\n" (builtins.readFile inputs.machine-id))}";
		environments = ["nixos" "minimal" "work"];
		username = "velasco";
	in {
		nixosConfigurations = let
			 configure = environment: {
				"${environment}" = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs stylix username environment machine; };
					modules = [
						./system/hw-config/${machine}.nix
						./system/configuration.nix
						./home/base.nix
					];
				};
			};
		in foldl (a: b: a // b) { } (
			forEach environments configure
		);
	};
}


