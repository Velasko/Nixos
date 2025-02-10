{ inputs, pkgs, lib, username, ... }: {
  imports = [
    ./waybar.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [ libpng eww dolphin ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      "$terminal" = "${pkgs.alacritty}/bin/alacritty";

      exec-once = [
        "${pkgs.waybar}/bin/waybar" # utility bar
        "${pkgs.hyprpaper}/bin/hyprpaper" # wallpaper
        "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator" # wifi manager tray
        "${pkgs.swaynotificationcenter}/bin/swaync"
        "systemctl --user start ${pkgs.hyprpolkitagent}/bin/hyprpolkitagent"
      ];

      input = {
        kb_layout = "br";
        touchpad.natural_scroll = true;
      };

      monitor = [ ", preferred, auto, 1" ];

      "$super" = "SUPER";

      bind = import ./hyprlandbinds.nix { inherit pkgs; };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };
}
