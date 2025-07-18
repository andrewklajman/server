{ config, pkgs, lib, ... }:

let
  cfg = config.services.mullvad-vpn;
#  mullvadSettingsDir = "/home/andrew/server/modules/mullvad/MULLVAD_SETTINGS_DIR";
  mullvadSettingsDir = "/home/andrew/Documents/notes/MULLVAD_SETTINGS_DIR";
in
with lib;
{
  options.mullvad.enable = lib.mkEnableOption "mullvad";

  config = lib.mkIf config.mullvad.enable {
    boot.kernelModules = [ "tun" ];
    environment.systemPackages = [ pkgs.mullvad-vpn ];
    systemd.services.mullvad-daemon = {
      description = "Mullvad VPN daemon";
      wantedBy = [ "multi-user.target" ];
      wants = [
        "network.target"
        "network-online.target"
      ];
      after = [
        "network-online.target"
        "NetworkManager.service"
        "systemd-resolved.service"
      ];
      path = lib.optional config.networking.resolvconf.enable config.networking.resolvconf.package;
      startLimitBurst = 5;
      startLimitIntervalSec = 20;
      serviceConfig = {
        # Environment = '' "MULLVAD_SETTINGS_DIR=${./MULLVAD_SETTINGS_DIR}" '';
        # Environment = '' "MULLVAD_SETTINGS_DIR=/home/andrew/server/modules/mullvad/MULLVAD_SETTINGS_DIR" '';
        Environment = '' "MULLVAD_SETTINGS_DIR=${mullvadSettingsDir}" '';
        ExecStart = "${cfg.package}/bin/mullvad-daemon -v --disable-stdout-timestamps";
        Restart = "always";
        RestartSec = 1;
      };
    };
  };


#Mullvad VPN daemon. Runs and controls the VPN tunnels
#
#Usage: mullvad-daemon [OPTIONS]
#
#Options:
#  -v...                                 Set the level of verbosity
#      --disable-log-to-file             Disable logging to file
#      --disable-stdout-timestamps       Don't log timestamps when logging to stdout, useful when running as a systemd service
#      --initialize-early-boot-firewall  Initialize firewall to be used during early boot and exit
#  -h, --help                            Print help
#  -V, --version                         Print version
#
#ENV:
#
#    MULLVAD_RESOURCE_DIR       Resource directory (i.e used to locate a root CA certificate)
#                               [Default: /nix/store/w2nshi5mnf6msw2s2a854wxgxfxdhq8d-mullvad-vpn-2025.3/bin]
#    MULLVAD_SETTINGS_DIR       Directory path for storing settings. [Default: /etc/mullvad-vpn]
#    MULLVAD_CACHE_DIR          Directory path for storing cache. [Default: /var/cache/mullvad-vpn]
#    MULLVAD_LOG_DIR            Directory path for storing logs. [Default: /var/log/mullvad-vpn]
#    MULLVAD_RPC_SOCKET_PATH    Location of the management interface device.
#                               It refers to Unix domain socket on Unix based platforms, and named pipe on Windows.
#                               [Default: /var/run/mullvad-vpn]
#

#    services.mullvad-vpn.enable = true;
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
#    systemd.services.mullvad-conn-check = {
#      enable = true;
#      serviceConfig.Type = "oneshot";
#      wantedBy = [ "multi-user.target" ];
#      after = [ "mullvad-conf.service" ];
#      script = "${pkgs.writers.writeBash "mullvad-conn-check" ''
#        ${pkgs.mullvad}/bin/mullvad status | ${pkgs.gnugrep}/bin/grep Connected
#      ''}";
#    };
#  };
}


