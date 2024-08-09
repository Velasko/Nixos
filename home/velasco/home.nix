{ username, pkgs, config, ... } : {
  imports = [
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
	./modules/programming.nix
	# ./system/${system}/config.nix
  ];

  programs.btop.enable = true;
  home.packages = with pkgs; [
		firefox
  ];
}
