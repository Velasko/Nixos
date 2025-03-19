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
    direnv
    lazygit
    lazydocker
    micro
    neovim
    tmux
    tree

    # Go
    go

    # Python
    python

    # Rust appls
    bacon
    cargo
    clippy
    # rustup
    rust-analyzer

    # nix programming
    nil

    # Dependencies
    gcc
    nodejs_22
    ripgrep # telescope dependency for file searching
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
    # ".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";
  };
}
