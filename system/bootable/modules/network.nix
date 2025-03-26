{ machine, username, ... }: {
  networking.networkmanager.enable = true;
  networking.hostName = "${username}-${machine}"; # Define your hostname.
  networking.hostId = "babaca01"; # Disko requirement

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
