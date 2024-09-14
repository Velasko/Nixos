{ environment, username, pkgs, ... }: {
  imports = [
    ./modules/xremap.nix
    ./modules/gitconfig.nix
    ./modules/shell.nix
    ./modules/stylix.nix
    ./modules/programming.nix
    ./modules/firefox.nix
    ./environments/${environment}.nix
  ];

  programs.btop.enable = true;
  programs.lazygit.enable = true;
  home.packages = with pkgs; [
    curl
    gnutar
    gzip
    wget
  ];
}
