{ config, pkgs, lib, ... }:

{
  imports = [
    ./agenix.nix
    ./environment.nix
    ./tailscale.nix
    ./mullvad.nix
    ./microsocks.nix
    ./qbittorrent-nox.nix
    ./audiobookshelf.nix
  ];
}

