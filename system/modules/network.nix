{ machine, environment, ... } : {
  networking.networkmanager.enable = true;
  networking.hostName = "${machine}-${environment}"; # Define your hostname.
  networking.hostId = "babaca01"; # Disko requirement

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
