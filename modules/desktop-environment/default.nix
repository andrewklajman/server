{ config, lib, pkgs, ... }:

let
  passmenulogin = pkgs.writeShellScriptBin "passmenulogin" '' ${builtins.readFile ./passmenulogin} '';
  is_dwm = ( config.desktop-manager == "dwm" );
in
{
  options.desktop-manager = lib.mkOption {
    type = lib.types.str;
    default = "dwm";
  };

  config = lib.mkIf is_dwm (import ./dwm { inherit config lib pkgs; } );

}

