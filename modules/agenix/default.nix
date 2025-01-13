{ config, pkgs, lib, age, ... }:

{
  options.agenix.enable = lib.mkEnableOption "agenix";

  config = lib.mkIf config.agenix.enable {
    age.identityPaths = [ "/root/.ssh/id_ed25519" ];
    age.secrets.tailscale.file = ../tailscale/tailscale.age;
  };
}
