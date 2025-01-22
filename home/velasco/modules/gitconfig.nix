{ lib, config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = lib.mkDefault "f.l.velasko@gmail.com";
    userName = lib.mkDefault "Velasco";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
