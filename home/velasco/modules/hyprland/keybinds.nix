{ pkgs, ... }: [
  # Base functionaliny
  "super, page_up, fullscreen" # super + F (xremap)
  "super shift, page_up, togglefloating" # super + shift + F (xremap)
  "super, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
  "shift super, L, exit,"
  "super, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
  "super, P, pin,"
  "super, Q, killactive"
  "super, R, exec, ${pkgs.rofi}/bin/rofi -show run"
  "super, T, exec, ${pkgs.alacritty}/bin/alacritty"

  # Arrow movement
  "super alt, Up, movefocus, u"
  "super alt, Left, movefocus, l"
  "super alt, Right, movefocus, r"
  "super alt, Down, movefocus, d"
  "super shift, Up, movewindow, u"
  "super shift, Left, movewindow, l"
  "super shift, Right, movewindow, r"
  "super shift, Down, movewindow, d"

  # Application shortcuts
  "super, 1, exec, ${pkgs.alacritty}/bin/alacritty --class yazi -e ${pkgs.yazi}/bin/yazi"
  "super, 2, exec, ${pkgs.firefox}/bin/firefox"

]
