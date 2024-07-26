{ config, pkgs, ... } : {
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

# Python
		python3

# Rust appls
		cargo
		# rustup
		rust-analyzer

# Dependencies
		gcc

  ];
}
