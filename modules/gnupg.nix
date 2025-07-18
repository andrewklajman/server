{ config, pkgs, lib, ... }:

{
  options.gnupg.enable = lib.mkEnableOption "gnupg";
  config = lib.mkIf config.gnupg.enable {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };
}
