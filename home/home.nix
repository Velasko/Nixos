{ username, pkgs, ... } : {
  imports = [
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.username = "${username}";

  programs.btop.enable = true;
  programs.alacritty.enable = true;
  home.packages = with pkgs; [
    # alacritty
		autojump
		direnv
#		discord
		firefox
		micro
		neovim
#		spotify
		stow
#		telegram
		tmux
		tree
#		vesktop
		wget
#		zoxide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ZSH_TMUX_AUTOSTART = "true";
  };

  programs.home-manager.enable = true;
}
