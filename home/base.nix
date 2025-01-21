{ config, inputs, lib, pkgs, environment, username, stylix, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        extraSpecialArgs = { inherit inputs pkgs environment username; };
        useUserPackages = true;
        useGlobalPkgs = true;
      };
    }
  ];

  home-manager.users."${username}" = {
    imports = [
      stylix.homeManagerModules.stylix
      ./${username}/home.nix
    ];


    home.homeDirectory = "/home/${username}";
    home.stateVersion = config.system.stateVersion;
    home.username = "${username}";

	gtk.enable = lib.mkforce false;

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      inconsolata-nerdfont
      libsecret
    ];
  };

  programs.steam.enable = environment != "work";
}
