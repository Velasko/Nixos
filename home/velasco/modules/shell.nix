{ pkgs, config, lib, ... } : {
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
      ls = "${pkgs.eza}/bin/eza";
      system = "FLAKE=~/.nixos nh os";
      home = "FLAKE=~/.nixos nh home";
      nix-clean = "nix-store --gc && nix-collect-garbage --delete old";
     };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/.zsh/history";
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
