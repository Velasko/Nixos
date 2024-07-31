{ username, pkgs, config, ... } : {
  imports = [
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
	./modules/programming.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.username = "${username}";

  fonts.fontconfig.enable = true;

  programs.btop.enable = true;
  home.packages = with pkgs; [
		# bitwarden-desktop
		# bitwardena-cli
		# discord
		firefox
		# spotify
		# telegram
		# vesktop

		inconsolata-nerdfont
		libsecret
  ];

  programs.home-manager.enable = true;
}
