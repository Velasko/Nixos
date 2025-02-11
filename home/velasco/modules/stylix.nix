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

  stylix.targets = {
    hyprland.enable = true;
    hyprpaper.enable = true;
    gtk.enable = true;
    gnome.enable = true;
  };
}

