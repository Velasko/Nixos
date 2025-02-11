{ pkgs, ... }: {
  # Hyprsunset service
  systemd.user.services.hyprsunset = {
    Install = {
      WantedBy = [ “default.target” ];
    };
    Service = {
      ExecStart = “${pkgs.hyprsunset}/bin/hyprsunset - t 2700”;
      Restart = “always”;
      Type = “simple”;
    };
    Unit = {
      Description = “Blue light filter service”;
    };
  };
}
