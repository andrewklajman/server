{ config, pkgs, lib, ... }:

{
  imports = [
    ./agenix
    ./audiobookshelf
    ./calibre.nix
    ./desktop-environment
    ./environment
    ./metube
    ./microsocks.nix
    ./mullvad.nix
    ./neovim.nix
    ./password-manager.nix
    ./qbittorrent-nox
    ./tailscale
   #./tor.nix
    ./virt-manager.nix
  ];

}

