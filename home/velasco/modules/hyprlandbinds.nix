{ pkgs, ... }: [
  # Base functionaliny
  "$super, F, togglefloating"
  "$super, L, exit,"
  "$super, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
  "$super, Q, exec, $terminal"
  "$super, R, exec, ${pkgs.rofi}/bin/rofi -show run"
  "$super, T, exec, $terminal"

  # Application shortcuts
  "$super, 1, exec, ${pkgs.yazi}/bin/yazi"

]
