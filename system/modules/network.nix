{ hostname, ... } : {
  networking.networkmanager.enable = true;
  networking.hostName = "${hostname}"; # Define your hostname.

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
