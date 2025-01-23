{ inputs, pkgs, config, lib, ... }:
let 
	config_path = "~/Nixos";
in {
  imports = [ ./powerline.nix ];

  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = lib.mkForce {
        family = "Inconsolata Nerd Font";
        style = "Regular";
      };
      font.bold = lib.mkForce {
        family = "Inconsolata Nerd Font";
        style = "Bold";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
		nix-update = "(cd ${config_path} && nix flake update --commit-lock-file)";
		nix-rebuild = "sudo nixos-rebuild --flake ${config_path}#main";
		nix-clean = "nix-store --gc && nix-collect-garbage --delete-old && sudo nix-collect-garbage -d";
		mkenv = ''
			makeDevEnvironment() {
				nix flake init -t "github:the-nix-way/dev-templates#$1"
			}; makeDevEnvironment() 
		'';
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
