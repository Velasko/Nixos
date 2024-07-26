{ username, pkgs, config, inputs, ... } : {
  imports = [
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
	./modules/programming.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.username = "${username}";

  fonts.fontconfig.enable = true;

  programs.btop.enable = true;
  programs.alacritty.enable = true;
  home.packages = with pkgs; [
#		discord
		firefox
#		spotify
#		telegram
#		vesktop

		inconsolata-nerdfont
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

  programs.home-manager.enable = true;
}
