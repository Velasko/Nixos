{ inputs, pkgs, lib, username, ... }: let
wallpaper = pkgs.fetchurl {
	url = "https://gruvbox-wallpapers.pages.dev/wallpapers/irl/village.jpg";
	hash = "sha256-t3ItqKeewcpGLoyFG4ch23stzGpaujFfANM++Aj3SDM";
};
in {
	imports = [ ./waybar.nix ];

	services.hyprpaper = {
		enable = true;
		settings = {
			wallpaper = [",${builtins.toString wallpaper}"];
			preload = [ ( builtins.toString wallpaper ) ];
		};
	};


	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		settings = {
			"$terminal" = "${pkgs.alacritty}/bin/alacritty";

			exec-once = [
				"${pkgs.waybar}/bin/waybar"
				"${pkgs.hyprpaper}/bin/hyprpaper"
			];

			input.kb_layout = "br";

			"$super" = "SUPER";

			bind = [
				"$super, T, exec, $terminal"
				"$super, M, exit,"
			];
		};
	};

}
