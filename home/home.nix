{ username, pkgs, config, ... } :
let
  dotfiles = builtins.fetchGit {
    url = "https://github.com/Velasko/dotfiles";
    rev = "4f55b5c58bd7f635dc4c5864740c3fa770725c33";
    ref = "nixos";
  };
in {
  imports = [
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.username = "${username}";

  fonts.fontconfig.enable = true;

  programs.btop.enable = true;
  programs.alacritty.enable = true;
  home.packages = with pkgs; [
		autojump
		direnv
#		discord
		firefox
		gcc
		lazygit
		micro
		neovim
		python3
		rustup
#		spotify
#		telegram
		tmux
		tree
#		vesktop
		wget
		inconsolata-nerdfont
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ZSH_TMUX_AUTOSTART = "true";
  };

  home.file = {
    ".tmux.conf".source = "${dotfiles}/.tmux.conf";
    ".tmux".source = "${dotfiles}/.tmux/";
    ".config/micro".source = "${dotfiles}/.config/micro/";
    ".config/nvim".source = "${dotfiles}/.config/nvim/";
  };

  programs.home-manager.enable = true;
}
