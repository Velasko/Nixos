{ pkgs, environment, username, ... }: {
  imports = [
    ./kde.nix
    ./greeter.nix
  ];

  services.displayManager.autoLogin.user = "${username}";
  services.displayManager.autoLogin.enable = false;
  services.dbus.enable = true;

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  services = {
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
      mouse.accelProfile = "flat";
    };

    xserver = {
      enable = true;
      xkb.layout = "br";
      exportConfiguration = true;

      displayManager.gdm.enable = false;
      desktopManager.gnome.enable = false;
    };
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware.graphics.enable = environment != "minimal";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
