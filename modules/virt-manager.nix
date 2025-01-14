# https://nixos.wiki/wiki/Virt-manager
{ config, pkgs, lib, ... }:

{
  options.virt-manager.enable = lib.mkEnableOption "virt-manager";

  config = lib.mkIf config.virt-manager.enable { 
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["andrew"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
