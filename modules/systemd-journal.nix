{ config, pkgs, ... }:

{

  systemd.timers."generate-journal" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 05:00:00";
        Persistent = "true";
        Unit = "generate-journal.service";
      };
  };
  
# ${pkgs.bash}/bin/bash -lc ${pkgs.python3}/bin/python3 /home/andrew/Documents/notes/scripts/generate_journal.py >> /home/andrew/Documents/notes/journal.md
      #
  systemd.services."generate-journal" = {
    enable = true;
    script = ''
      ${pkgs.python3}/bin/python3 /home/andrew/Documents/notes/scripts/generate_journal.py
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "andrew";
    };
  };



}
