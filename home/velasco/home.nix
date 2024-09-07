{ environment, username, pkgs, ... } : {
	imports = [
		./modules/gitconfig.nix
		./modules/shell.nix
		./modules/stylix.nix
		./modules/programming.nix
		./systems/${environment}.nix
	];

	programs.btop.enable = true;
	programs.lazygit.enable = true;
	home.packages = with pkgs; [
		firefox
	];
}
