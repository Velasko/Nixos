{ config, pkgs, ... } : {
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pop.yaml";
  stylix.cursor.package = pkgs.apple-cursor;
  stylix.cursor.name = "macOS-BigSur-White";

  stylix.image = ../../home/${username}/wallpaper.png;
  stylix.polarity = "dark";
  stylix.enable = true;
}

