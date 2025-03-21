{ inputs, pkgs, config, lib, username, ... }: {
  imports = [
    ./waybar.nix
    ./yazi.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprsunset.nix
    ./polkit-agent.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [ ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    settings = {
      "$terminal" = "${pkgs.alacritty}/bin/alacritty";

      exec-once = [
        "${pkgs.hyprland}/bin/hyprctl setcursor ${config.stylix.cursor.name} ${builtins.toString config.stylix.cursor.size}"
        "${pkgs.hypridle}/bin/hypridle"
        "pidof ${pkgs.waybar}/bin/waybar || ${pkgs.waybar}/bin/waybar" # utility bar
        "${pkgs.hyprpaper}/bin/hyprpaper" # wallpaper
        "${pkgs.swaynotificationcenter}/bin/swaync"
        "${pkgs.systemd}/bin/systemctl --user start polkit-gnome-authentication-agent-1.service"
      ];

      input = {
        kb_layout = "br";
        touchpad.natural_scroll = true;
        kb_options = [ "caps:swapescape" ];
      };

      monitor = [ ", preferred, auto, 1" ];

      bind = import ./keybinds.nix { inherit pkgs; };
      bindm = [
        "super, mouse:273, resizewindow"
        "super, mouse:272, movewindow"
      ];

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      general = {
        gaps_out = 0;
        gaps_in = 2;
      };

    };
  };
}
