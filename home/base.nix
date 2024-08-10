{ pkgs, config, hostname, username, ... } : {
	imports = [
		./${username}/home.nix
	];

	nixpkgs.config.allowUnfree = true;

	home.homeDirectory = "/home/${username}";
	home.stateVersion = "24.05";
	home.username = "${username}";

	fonts.fontconfig.enable = true;
	programs.home-manager.enable = true;
}
