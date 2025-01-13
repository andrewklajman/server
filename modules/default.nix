{ config, pkgs, lib, ... }:

{
  imports = [
    ./agenix
    ./audiobookshelf
    ./desktop-environment
    ./environment
    ./metube
    ./microsocks.nix
    ./mullvad.nix
    ./password-manager.nix
    ./qbittorrent-nox
    ./tailscale
   #./tor.nix
  ];
}

