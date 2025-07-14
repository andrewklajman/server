{ config, pkgs, lib, ... }:

{
  options.rustDev.enable = lib.mkEnableOption "rustDev";
  config = lib.mkIf config.rustDev.enable  {
    environment.systemPackages = with pkgs; [ 
      cargo 
      rustc 
    ];
  };
}
