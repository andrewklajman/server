{ config, pkgs, lib, agenix, ... }:

{
  imports = [
    ../configuration.nix 

    ./agenix.nix
    ./environment.nix
    ./tailscale.nix
    ./mullvad.nix
    ./microsocks.nix
    ./qbittorrent-nox.nix
    ./audiobookshelf.nix

    {
      tailscale.enable = true;
      mullvad.enable = true;
      microsocks.enable = true;
      qbittorrent-nox.enable = true;

      virtualisation.oci-containers.backend = "docker"; # Podman: localhost:XXXX works; nixos:XXXX fails
      audiobookshelf.enable = true;
    }

  ];
}

