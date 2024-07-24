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
     };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/.zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
      	"git"
      	"autojump"
      	"rust"
      	"tmux"
      	"web-search"
      	"direnv"
      ];
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = [
    "--cmd=cd"
  ];
}
