{ config, pkgs, ... }:
{
  services.emacs = {
    enable = true;
    package = config.programs.emacs.package;
	startWithUserSession = true;
  };

	programs.emacs = {
		enable = true;
		package = pkgs.emacs-nox;
		extraPackages = pkgs: [ pkgs.dracula-theme ];
		extraConfig = ''
			(custom-set-variables
				'(xterm-mouse-mode t))
				 '(cua-mode t)
				 '(desktop-save-mode t)
		'';
	};
}
