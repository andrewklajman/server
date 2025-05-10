{ config, pkgs, lib, ... }:

{
  options.systemd-journal.enable = lib.mkEnableOption "systemd-journal";

  config = lib.mkIf config.systemd-journal.enable {
    systemd.timers."generate-journal" = {
      wantedBy = [ "timers.target" ];
        timerConfig = {
          #OnCalendar = "*:5/10";
          OnCalendar = "daily";
          Persistent = "true";
          Unit = "generate-journal.service";
        };
    };
    
  # ${pkgs.bash}/bin/bash -lc ${pkgs.python3}/bin/python3 /home/andrew/Documents/notes/scripts/generate_journal.py >> /home/andrew/Documents/notes/journal.md
        #${pkgs.python3}/bin/python3 /home/andrew/Documents/notes/scripts/generate_journal.py
        #
    systemd.services."generate-journal" = {
      enable = true;
      script = ''
        ${pkgs.git}/bin/git -C /home/andrew/Documents/notes add .
        ${pkgs.git}/bin/git -C /home/andrew/Documents/notes commit -m 'Auto Commit'
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "andrew";
      };
    };
  };
}
