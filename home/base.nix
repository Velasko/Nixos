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

	# If kde is on -> annoying files interrupts the build
	# If gtk is off -> gtk apps don't follow stylix themes
	gtk.enable = lib.mkForce (!config.services.desktopManager.plasma6.enable);

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      inconsolata-nerdfont
      libsecret
    ];
  };

  programs.dconf.enable = true;
  programs.steam.enable = environment != "work";
}
