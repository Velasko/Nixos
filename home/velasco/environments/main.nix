{ pkgs, ... }: {
  imports = [ ./graphical.nix ];

  home.packages = with pkgs; [
    bitwarden-desktop
    bitwarden-cli
    discord
    openvpn
    spotify
    telegram-desktop
    vesktop
    unzip
    vlc
    wine

    kdePackages.okular
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibility.d";
    LD_LIBRARY_PATH = "${pkgs.nix-ld}/lib:$LD_LIBRARY_PATH";
  };
}
