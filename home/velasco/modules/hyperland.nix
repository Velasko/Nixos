{ pkgs, ... }: {
	imports = [ ./waybar.nix ];


	wayland.windowManager.hyprland = {
		enable = true;
		settings.input.kb_layout = true;
	};
}
