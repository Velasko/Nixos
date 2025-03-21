{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = epkgs: [ epkgs.dracula-theme ];
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };
}
