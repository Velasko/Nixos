{ config, pkgs, ... } : {
  programs.git = {
    enable = true;
    userEmail = "f.l.velasko@gmail.com";
    userName = "Velasko";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
