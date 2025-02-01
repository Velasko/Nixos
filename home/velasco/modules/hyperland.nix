{ inputs, pkgs, lib, username, ... }: {
	imports = [ ./waybar.nix ];

	home.packages = with pkgs; [ libpng ];

	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		settings = {
			"$terminal" = "${pkgs.alacritty}/bin/alacritty";

			exec-once = [
				"${pkgs.waybar}/bin/waybar"
				"${pkgs.hyprpaper}/bin/hyprpaper"
				"${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
			];

			input.kb_layout = "br";

			"$super" = "SUPER";

			bind = [
				"$super, T, exec, $terminal"
				"$super, M, exit,"
			];

		misc = {
			force_default_wallpaper = 0;
			disable_hyprland_logo = true;
		};

		};
	};
}
