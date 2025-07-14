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
    ./rustDev.nix
    ./systemd-journal.nix
    ./systemd-recur-task.nix
    ./tailscale
   #./tor.nix
    ./virt-manager.nix

  ];

}

