{ inputs, pkgs, config, lib, machine, environment, ... }:
let
  config_path = "~/Nixos";
in
{
  imports = [ ./powerline.nix ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      please = "sudo";
      nix-update = "(cd ${config_path} && nix flake update --commit-lock-file)";
      nix-rebuild = "sudo nixos-rebuild --flake ${config_path}#${machine}.${environment}";
      nix-clean = "nix-store --gc && nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && rm -rf ~/.cache/nix";
      nix-iso = "nix run nixpkgs#nixos-generators -- --format iso --flake ~/Nixos#iso -o ~/result";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/.zsh/history";
    };

    sessionVariables = {
      BASE16_THEME = "pop";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "autojump"
        "command-not-found"
        "direnv"
        "fluxcd"
        "fzf"
        "git"
        "rust"
        "tmux"
        "themes"
        "web-search"
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = [
    "--cmd=cd"
  ];
}
