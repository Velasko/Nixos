{ pkgs, username, ... }: {
	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
				user = username;
			};
		};
	};

	# hiding boot messages
	systemd.servces.greetd.serviceConfig = {
		Type = "idle";
		StandardInput = "tty";
		StandardOutput = "tty";
		StandardError = "journal";

		TTYReset = true;
		TTYVHangup = true;
		TTYVTDisallocate = true;
	};
}
