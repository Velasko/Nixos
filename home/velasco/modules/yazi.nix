{ pkgs, ... }: {
	home.packages = with pkgs; [ 
		yazi

		#dependencies
		# ffmpeg
		# p7zip
		# jq
		# poppler
		# imagemagick
	];
}
