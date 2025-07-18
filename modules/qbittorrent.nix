{ config, pkgs, lib, ... }:

{
  options.qbittorrent.enable = lib.mkEnableOption "qbittorrent";

  config = lib.mkIf config.qbittorrent.enable {
    environment.systemPackages = [ pkgs.qbittorrent ];
  };
}

