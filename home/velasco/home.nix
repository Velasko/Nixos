{ environment, username, pkgs, ... }: {
  imports = [
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
    ./modules/programming.nix
    ./environments/${environment}.nix
  ];

  programs = {
    lazygit.enable = true;

    # monitoring tools
    btop.enable = true;
    # iftop.enable = true; # networking
    # iotop.enable = true; # disk
    # csysdig.enable = true; # disk
    # nvtop.enable = true; # gpu
    # nvtopPackages.full.enable = true; # gpu
  };


  home.packages = with pkgs; [
    curl
    gnutar
    gzip
    wget
  ];

}
