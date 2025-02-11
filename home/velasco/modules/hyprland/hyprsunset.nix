{ config, pkgs, ... }: {
  # Hyprsunset service
  systemd.user.services.hyprsunset = {
    Service = {
      ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset -t 2700";
      Restart = "on-failure";
      Type = "simple";
    };

    Unit = {
      Description = "Blue light filter service";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

  };

  systemd.user.timers = {
    nightlight = {
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        # OnBootSec = "1m";
        # OnUnitActiveSec = "1m";
        OnCalendar = "*-*-* 18:00:00";
        Persistent = true;
        Unit = "hyprsunset.service";
      };
    };
  };

}
