{ pkgs, config, username, ... }: {
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.programs.zsh.sessionVariables.BASE16_THEME}.yaml";
  stylix.cursor = {
    package = pkgs.volantes-cursors;
    name = "volantes_cursors";
    size = 22;
  };

  stylix.image = ../../../home/${username}/wallpaper.jpeg;
  stylix.polarity = "dark";
  stylix.enable = true;

  stylix.fonts = {
    sansSerif = {
      package = pkgs.inconsolata-nerdfont;
      name = "Inconsolata Nerd Font";
    };
    serif = config.stylix.fonts.sansSerif;
    monospace = config.stylix.fonts.sansSerif;
    emoji = config.stylix.fonts.sansSerif;
  };

}
