{ config, pkgs, ... }:

{

  systemd.timers."task-daily-routine" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 08:45:00";
        Persistent = "true";
        Unit = "task-daily-routine.service";
      };
  };
  
  systemd.services."task-daily-routine" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.taskwarrior3}/bin/task add "Morning routine test
      * Coffee
      * Stretching
      * Clean
      * Breakfast" 
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "andrew";
    };
  };

}
