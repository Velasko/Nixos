{ config, pkgs, inputs, ... }:
let
  python = pkgs.python312;
  pythonPkgs = pkgs.python312Packages;
in
{
  programs.alacritty.enable = true;

  home.packages = with pkgs; [
    # env/shell/utils
    autojump
    curl
    direnv
    lazygit
    micro
    neovim
    gnutar
    tmux
    tree
    wget

    # Python
    python

    # Rust appls
    bacon
    cargo
    clippy
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
