{ inputs, pkgs, lib, username, ... }: {
	imports = [ ./waybar.nix ];

	home.packages = with pkgs; [ libpng eww yazi dolphin ];

	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		systemd.enable = true;
		settings = {
			"$terminal" = "${pkgs.alacritty}/bin/alacritty";

			exec-once = [
				"${pkgs.waybar}/bin/waybar" # utility bar
				"${pkgs.hyprpaper}/bin/hyprpaper" # wallpaper
				"${pkgs.networkmanagerapplet}/bin/nm-applet --indicator" # wifi manager tray
				"${pkgs.swaynotificationcenter}/bin/swaync"
				"systemctl --user start ${pkgs.hyprpolkitagent}/bin/hyprpolkitagent"
			];

			input = {
				kb_layout = "br";
				touchpad.natural_scroll = true;
			};
			
			monitor = [", preferred, auto, 1"];

			"$super" = "SUPER";

			bind = [
				"$super, T, exec, $terminal"
				"$super, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
				"$super, R, exec, ${pkgs.rofi}/bin/rofi -show run"
				"$super, L, exit,"
			];

			misc = {
				force_default_wallpaper = 0;
				disable_hyprland_logo = true;
			};
		};
	};
}
