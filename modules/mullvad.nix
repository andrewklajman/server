{ config, pkgs, lib, ... }:

{
  options.mullvad.enable = lib.mkEnableOption "mullvad";

  config = lib.mkIf config.mullvad.enable {
    services.mullvad-vpn.enable = true;

#    systemd.services.mullvad-conf = {
#      enable = true;
#      serviceConfig.Type = "oneshot";
#      wantedBy = [ "multi-user.target" ];
#      after = [ "mullvad-daemon.service" ];
#      script = "${pkgs.writers.writeBash "mullvad-configure" ''
#	${pkgs.coreutils}/bin/sleep 5
#        ${pkgs.mullvad}/bin/mullvad lockdown-mode set on
#        ${pkgs.mullvad}/bin/mullvad lan set allow
#        ${pkgs.mullvad}/bin/mullvad relay set location au
#        ${pkgs.mullvad}/bin/mullvad connect
#      ''}";
#    };
#
#    systemd.services.mullvad-conn-check = {
#      enable = true;
#      serviceConfig.Type = "oneshot";
#      wantedBy = [ "multi-user.target" ];
#      after = [ "mullvad-conf.service" ];
#      script = "${pkgs.writers.writeBash "mullvad-conn-check" ''
#        ${pkgs.mullvad}/bin/mullvad status | ${pkgs.gnugrep}/bin/grep Connected
#      ''}";
#    };

  };
}
