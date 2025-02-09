{ pkgs, ... }: {
	programs.yazi.enable = true;
	
	#UX dependencies
	home.packages = with pkgs; [ 
		ffmpeg
		p7zip
		jq
		poppler
		imagemagick
	];
}
