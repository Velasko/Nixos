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
		extraPackages = pkgs: with pkgs; [
		  all-the-icons
			centaur-tabs
			vertico
		];
	};

	home.file.".emacs".text = ''
(custom-set-variables
	'(xterm-mouse-mode t)
	'(cua-mode t)
	'(desktop-save-mode t)
	'(save-place-mode t)
	'(global-display-line-numbers-mode t)
)

(use-package centaur-tabs
  :init
  (centaur-tabs-mode t)
  (setq centaur-tabs-enable-key-bindings t)
  (setq centaur-tabs-style "wave"
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-ace-jump t

        ;; tab selected highlight:
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t

        ;; Close/modified icon:
        ;;centaur-tabs-close-button "X"
        centaur-tabs-set-modified-marker t
        ;; centaur-tabs-modified-marker "*"

        ;; not working:
        centaur-tabs-set-icons t
  )
  :config
  (centaur-tabs-headline-match)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-right)
  ("C-M-<next>" . centaur-tabs-ace-jump)
)
'';
}
