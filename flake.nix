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
		machine-id-file = {
			flake = false;
			url = "path:/etc/machine-id";
		};
		cpu-info = {
			flake = false;
			url = "path:/proc/cpuinfo";
		};
	};

	outputs = { nixpkgs, home-manager, stylix, ... } @inputs :
	let
		inherit (nixpkgs.lib.lists) foldl forEach;
		inherit (nixpkgs.lib.strings) concatStrings splitString hasInfix;

		pkgs = import nixpkgs {
			config.allowUnfree = true;
			inherit platform;
		};

		virtualized = hasInfix "hypervisor" (builtins.readFile inputs.cpu-info);
		platform = pkgs.config.nixpkgs.hostPlatform;
		machines = {
			id_996b67fbf5c84008b8c18e234824785e = "book4";
			id_db8e3934eee544689f3e2460bef7a0d8 = "zfs-virtualized";
		};
		machine-id = concatStrings (splitString "\n" (builtins.readFile inputs.machine-id-file));

		machine = (machines."id_${machine-id}" or "unknown");
		environments = ["nixos" "minimal" "work"];
		username = "velasco";
		hostname = "Velasco-${machine}";
	in {
		nixosConfigurations = let
			 configure = environment: {
				"${environment}" = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs stylix hostname username environment machine virtualized; };
					modules = [
						./system/${machine}/hardware-configuration.nix
						./system/configuration.nix
						./home/base.nix
					];
				};
			};
		in foldl (a: b: a // b) {
		} (
			forEach environments configure
		);
	};
}


