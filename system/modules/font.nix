{ pkgs, ... } : {

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "Inconsolata" ]; })
	];
	fonts.fontDir.enable = true;

}
