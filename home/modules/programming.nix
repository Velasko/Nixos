{ config, pkgs, ... } : {
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

# Python
		python3

# Rust appls
		cargo
		# rustup
		rust-analyzer

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
