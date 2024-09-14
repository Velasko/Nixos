{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
    kate
  ];
}
