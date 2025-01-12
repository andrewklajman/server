{ config, pkgs, lib, ... }:

{
  options.metube = { enable = lib.mkEnableOption "metube"; };

#    users.users.metube = {
#      isNormalUser = true;
#      description = "metube";
#      shell = "${pkgs.coreutils}/bin/false";
#      packages = [ pkgs.qbittorrent-nox ];
#      hashedPassword = "!";
#    };

  config = lib.mkIf config.metube.enable {
    virtualisation.oci-containers.containers.metube = {
      image = "ghcr.io/alexta69/metube";
      ports = [ "8081:8081" ];
      volumes = [ "/etc/nixos/secrets/ssl:/ssl" ];
      user= "root";
      extraOptions = [ "--restart=always" ];
      environment = {
        HTTPS = "true";
	CERTFILE = "/ssl/cert.pem";
        KEYFILE = "/ssl/key.pem";
      };
    };
  };
}
