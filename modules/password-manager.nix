# TODO : Restart function
# TODO : Backup function
# TODO : Native installation

{ config, pkgs, lib, ... }:

let 
  data_dir = config.password-manager.data_dir;
in 
{
  options.password-manager = {
    enable = lib.mkEnableOption "password-manager";
    data_dir = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/vaultwarden";
    };
  };

  config = lib.mkIf config.password-manager.enable { 
    virtualisation.oci-containers.containers.vaultwarden = {
      image = "vaultwarden/server:latest";
      ports = [ "80:80" ];
      volumes = [ "${data_dir}/data:/data/" ];
      extraOptions = [ "--restart" ];
    };
  };
 
# Linux pass
#    * https://github.com/emersion/webpass
#    * https://github.com/BenoitZugmeyer/pass-web
#    * https://github.com/cortex/ripasso : Is it possibel to serve gtk app  as a web service?




}

