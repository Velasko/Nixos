{ username, pkgs, config, ... }: {
  	stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.programs.zsh.sessionVariables.BASE16_THEME}.yaml";
	stylix.cursor.package = pkgs.apple-cursor;
	stylix.cursor.name = "macOS-BigSur-White";

	stylix.image = ../../../home/${username}/wallpaper.png;
	stylix.polarity = "dark";
	stylix.enable = true;

	stylix.targets = {
		hyprland.enable = true;
		hyprpaper.enable = true;
	};
}

