{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
	wayland.enable = true;
  };

  programs.hyprland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
    kate
  ];
}
