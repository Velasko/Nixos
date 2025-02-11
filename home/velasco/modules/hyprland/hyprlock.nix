{ config, lib, ... }: {
  programs.hyprlock = {
    enable = true;
    settings =
      let
        color = config.lib.stylix.colors;
      in
      {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        background = lib.mkForce [
          {
            monitor = "";
            path = "screenshot";
            blur_passes = 2;
            blur_size = 2;
            new_optimizations = true;
            ignore_opacity = false;
          }
        ];

        input-field = lib.mkForce [
          {
            monitor = "";
            size = "300, 50";
            outline_thickness = 2;
            outer_color = "rgb(${color.base03})";
            inner_color = "rgb(${color.base00})";
            font_color = "rgb(${color.base07})";
            # check_color = "rgb(${color.base0B})";
            fail_color = "rgb(${color.base08})";
            fade_on_empty = false;
            placeholder_text = "<i>Enter Password</i>";
            dots_spacing = 0.2;
            dots_center = true;
            position = "0, 125";
            valign = "bottom";
            halign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = "cmd[update:3600000] date +'%A, %B %d'";
            font_family = "Inconsolata Nerd Font Propo Bold";
            font_size = 36;
            color = "rgb(${color.base07})";
            position = "0, -150";
            valign = "top";
            halign = "center";
          }
          {
            monitor = "";
            text = "$TIME";
            font_family = "Inconsolata Nerd Font Propo Bold";
            font_size = 132;
            color = "rgb(${color.base07})";
            position = "0, -200";
            valign = "top";
            halign = "center";
          }
          {
            monitor = "";
            text = "   $USER";
            font_family = "Inconsolata Nerd Font Propo Bold";
            font_size = 24;
            color = "rgb(${color.base07})";
            position = "0, 200";
            valign = "bottom";
            halign = "center";
          }
        ];
      };
  };
}
