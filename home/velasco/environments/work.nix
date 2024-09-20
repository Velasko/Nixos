{ pkgs, ... }: {
  programs.git = {
    userEmail = "filipe.velasco@siemens-energy.com";
    userName = "Luís Filipe Velasco";
  };

  home.packages = with pkgs; [
    # keepass
    # teams-for-linux
    # unzip
    # vlc
  ];
}
