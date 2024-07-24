{ pkgs, ... } : {

	fonts.packages = with pkgs; [
		nerdfonts
	];
	fonts.fontDir.enable = true;

}
