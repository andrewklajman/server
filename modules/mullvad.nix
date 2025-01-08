{ config, pkgs, lib, ... }:

# It looks like this does not present many options to configure Mullvad.
# So I will need to 
#    * Log in
#    * Turn on Lockdown mode
#    * Make LAN services available
#    * set to au

{
  options.mullvad.enable = lib.mkEnableOption "mullvad";

  config = lib.mkIf config.mullvad.enable {
    services.mullvad-vpn.enable = true;
  };
}
