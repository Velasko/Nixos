{ environment, ... } : {
  networking.networkmanager.enable = true;
  networking.hostName = "${environment}"; # Define your hostname.
  networking.hostId = "babaca01"; # Disko required

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
