{ config, pkgs, inputs, ... } :
let
	python = pkgs.python312;
	pythonPkgs = pkgs.python312Packages;
in {
	programs.alacritty.enable = true;

	home.packages = with pkgs; [
# env/shell/utils
		autojump
		direnv
		lazygit
		micro
		neovim
		tmux
		tree
		wget

		# Lua
		lua-language-server

		# Python
		python
		# pythonPkgs.jedi-language-server
		# ruff

		# Rust appls
		bacon
		cargo
		clippy
		# rustup
		rust-analyzer

# Nix
		nil

# Dependencies
		gcc
	];

	home.sessionVariables = {
	EDITOR = "nvim";
	ZSH_TMUX_AUTOSTART = "true";
	};

	home.file = {
	".tmux.conf".source = "${inputs.dotfiles}/.tmux.conf";
	".tmux".source = "${inputs.dotfiles}/.tmux/";
	".config/micro".source = "${inputs.dotfiles}/.config/micro/";
	".config/nvim".source = "${inputs.dotfiles}/.config/nvim/";
	};
}
