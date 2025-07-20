{ config, pkgs, lib, ... }:
{
  imports = [
    ./audiobookshelf.nix
    ./calibre.nix
    ./desktop-environment
    ./doas.nix
    ./docker.nix
    ./environment.nix
    ./gnupg.nix
    ./metube
    ./microsocks.nix
    ./mullvad.nix
    ./neovim.nix
    ./password-manager.nix
    ./qbittorrent.nix
    ./systemd-journal.nix
    ./systemd-recur-task.nix
    ./tailscale
    ./taskwarrior.nix
    ./tmux.nix
    ./virt-manager.nix
    ./zsh.nix
  ];
}

