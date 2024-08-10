{ pkgs, ... } : {
	home.packages = with pkgs; [
		keepass
		teams-for-linux
		unzip
		vlc
	];
}
