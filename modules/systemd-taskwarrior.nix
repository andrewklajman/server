{ config, pkgs, ... }:

{

# [Unit]
# Description=Daily man-db regeneration
# Documentation=man:mandb(8)
# 
# [Timer]
# OnCalendar=daily
# AccuracySec=12h
# Persistent=true
# 
# [Install]
# WantedBy=timers.target

  systemd.timers."task-daily-routine" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 05:00:00";
        Persistent = "true";
        Unit = "task-daily-routine.service";
      };
  };
  
  systemd.services."task-daily-routine" = {
    enable = true;
    script = ''
      ${pkgs.taskwarrior3}/bin/task add "Morning routine
      * Clean
      * Coffee
      * Check tasks
      * Stretching
      * Shower" until:1400 rc.dateformat:HN +next
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "andrew";
    };
  };



}
