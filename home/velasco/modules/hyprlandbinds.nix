{ pkgs, ... }: [
  # Base functionaliny
  "$super, page_up, fullscreen" # super + F (xremap)
  "$ssuper, page_up, togglefloating" # super + shift + F (xremap)
  "$super, L, exit,"
  "$super, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
  "$super, Q, killactive"
  "$super, R, exec, ${pkgs.rofi}/bin/rofi -show run"
  "$super, T, exec, ${pkgs.alacritty}/bin/alacritty"

  # Arrow movement
  "alt, Up, movefocus, u"
  "alt, Left, movefocus, l"
  "alt, Right, movefocus, r"
  "alt, Down, movefocus, d"
  "super alt, up, movewindow, u"
  "super alt, Left, movewindow, l"
  "super alt, Right, movewindow, r"
  "super alt, Down, movewindow, d"

  # Application shortcuts
  "$super, 1, exec, ${pkgs.alacritty}/bin/alacritty --class yazi -e ${pkgs.yazi}/bin/yazi"
  "$super, 2, exec, ${pkgs.firefox}/bin/firefox"

]
