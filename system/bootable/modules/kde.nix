{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = false;
    autoNumlock = true;
	wayland.enable = true;
  };

  programs.hyprland.enable = false;
  services.desktopManager.plasma6.enable = false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
    kate
  ];
}
