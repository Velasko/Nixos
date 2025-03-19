{ pkgs, ... }: [
  # Base functionaliny
  "super, F, fullscreenstate, 1"
  "super alt, F, fullscreen"
  "super shift, F, togglefloating"
  "super, L, exec, ${pkgs.systemd}/bin/loginctl lock-session"
  "super shift, L, exec, ${pkgs.systemd}/bin/loginctl terminate-user $USER"
  "super alt, L, exit,"
  "super, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
  "super, P, pin,"
  "super, Q, killactive"
  "super, R, exec, ${pkgs.rofi}/bin/rofi -show drun"
  "super, T, exec, ${pkgs.alacritty}/bin/alacritty"
  "super shift, S, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy"

  # Arrow movement
  "super alt, Up, movefocus, u"
  "super alt, Left, movefocus, l"
  "super alt, Right, movefocus, r"
  "super alt, Down, movefocus, d"
  "super shift, Up, movewindow, u"
  "super shift, Left, movewindow, l"
  "super shift, Right, movewindow, r"
  "super shift, Down, movewindow, d"

  # floating window movement
  "alt, tab, cyclenext, visible floating"
  # Application shortcuts
  "super, 1, exec, ${pkgs.alacritty}/bin/alacritty --class yazi -e ${pkgs.yazi}/bin/yazi"
  "super, 2, exec, ${pkgs.firefox}/bin/firefox"

]
