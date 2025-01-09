{ config, pkgs, lib, ... }:

let 
  data_dir = config.audiobookshelf.data_dir;
  config_dir = config.audiobookshelf.config_dir;
in 
{
  options.audiobookshelf = { 
    enable = lib.mkEnableOption "audiobookshelf";
    data_dir = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/audiobookshelf";
    };
    config_dir = lib.mkOption {
      type = lib.types.str;
      default = "/etc/nixos/files/abs_config";
    };
  };

  config = lib.mkIf config.audiobookshelf.enable {
    virtualisation.oci-containers.containers.audiobookshelf = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      ports = [ "13378:80" ];
      volumes = [
        "${config_dir}:/config"
        "${data_dir}/audiobooks:/audiobooks"
        "${data_dir}/podcasts:/podcasts"
        "${data_dir}/metadata:/metadata"
      ];
    };

  };
}
