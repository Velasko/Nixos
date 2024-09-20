{ lib, config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = lib.mkDefault "f.l.velasko@gmail.com";
    userName = lib.mkDefault "Velasko";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
