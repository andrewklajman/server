{ config, pkgs, lib, ... }:

let 
  home_directory = config.audiobookshelf.home_directory;
in 
{
  options.audiobookshelf = { 
    enable = lib.mkEnableOption "audiobookshelf";
    home_directory = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/audiobookshelf";
    };
  };

  config = lib.mkIf config.audiobookshelf.enable {
    virtualisation.oci-containers.containers.audiobookshelf = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      ports = [ "13378:80" ];
      volumes = [
        "${home_directory}/audiobooks:/audiobooks"
        "${home_directory}/podcasts:/podcasts"
        "${home_directory}/metadata:/metadata"
        "${home_directory}/config:/config"
      ];
    };

    systemd.services.podman-audiobookshelf.serviceConfig = {
      ExecStartPre = "${
        pkgs.writers.writeBash "createvolumes" ''
          ${pkgs.coreutils}/bin/mkdir -p ${home_directory}/audiobooks
          ${pkgs.coreutils}/bin/mkdir -p ${home_directory}/podcasts
          ${pkgs.coreutils}/bin/mkdir -p ${home_directory}/metadata
          ${pkgs.coreutils}/bin/mkdir -p ${home_directory}/config
        ''
      }";
    };

  };

}
