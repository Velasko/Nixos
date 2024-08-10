{ pkgs, ... } : {
	home.packages = with pkgs; [
		# bitwarden-desktop
		# bitwardena-cli
		# discord
		# spotify
		# telegram
		# vesktop
		# unzip
		# vlc
		# wine
	];

	home.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibility.d";
		LD_LIBRARY_PATH="${pkgs.nix-ld}/lib:$LD_LIBRARY_PATH";
	};
}
