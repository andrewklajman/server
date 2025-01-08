{ config, pkgs, lib, age, ... }:

{
  age.identityPaths = [ "/root/.ssh/id_ed25519" ];
  age.secrets.tailscale.file = ../secrets/tailscale.age;
}
