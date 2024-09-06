{ hostname, ... } : {
  networking.networkmanager.enable = true;
  networking.hostName = "${hostname}"; # Define your hostname.
  networking.hostId = "babaca01"; # Disko required

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
