{ config, pkgs, lib, ... }:

let 
  conf_location = config.qbittorrent-nox.conf_location;
  source_location = config.qbittorrent-nox.source_location;
in
{
  options.qbittorrent-nox = {
    enable = lib.mkEnableOption "qbittorrent-nox";
    conf_location = lib.mkOption {
      type = lib.types.str;
      default = "/home/torrent/.config/qBittorrent";
    };
    source_location = lib.mkOption {
      type = lib.types.str;
      default = "/etc/nixos/files";
    };
  };

  config = lib.mkIf config.qbittorrent-nox.enable {
    users.users.torrent = {
      isNormalUser = true;
      description = "torrent";
      shell = "${pkgs.coreutils}/bin/false";
      packages = [ pkgs.qbittorrent-nox ];
      hashedPassword = "!";
    };

    systemd.services.qbittorrent-nox = {
      enable = true;
      script = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      serviceConfig = {
        NonBlocking = "true";
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = "5";
        RuntimeDirectoryMode = "0750";
        User = "torrent";

        # This will fail on a new installation since ti returns a error code (and so stopping the remainder of the service)
        ExecStartPre = "${pkgs.writers.writeBash "conf-update" '' 
          rm ${conf_location}/qBittorrent.conf
          cp ${source_location}/qBittorrent.conf ${conf_location}/qBittorrent.conf
          rm ${conf_location}/categories.json
          cp ${source_location}/categories.json ${conf_location}/categories.json
        ''}";

        ExecStop = "${pkgs.writers.writeBash "conf-backup" ''
          cp ${conf_location}/qBittorrent.conf ${source_location}/qBittorrent.conf
          cp ${conf_location}/categories.json ${source_location}/categories.json 
        ''}";
      };
      wantedBy = [ "multi-user.target" ];
    };

  };
}

