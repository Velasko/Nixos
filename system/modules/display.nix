{ username, pkgs, ... } : {
  services.displayManager.autoLogin.user = "${username}";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.dbus.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ 
    pkgs.xdg-desktop-portal-gtk 
  ];

  services.xserver = {
    xkb.layout = "br";
    enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
	kate
  ];
  
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware.opengl.enable = true;

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;	

  environment.systemPackages = with pkgs; [
  ];
}
