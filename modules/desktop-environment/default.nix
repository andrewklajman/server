{ config, lib, pkgs, ... }:

let
  passmenulogin = pkgs.writeShellScriptBin "passmenulogin" '' ${builtins.readFile ./passmenulogin} '';
  is_dwm = ( config.desktop-manager == "dwm" );
  is_gnome = ( config.desktop-manager == "gnome" );
  module_dwm = (import ./dwm { inherit config lib pkgs; } );
  module_gnome = (import ./gnome { inherit config lib pkgs; } );

# Create kde, twm


in
{
  options.desktop-manager = lib.mkOption {
    type = lib.types.str;
    default = "dwm";
  };
  #config = lib.mkIf is_dwm (import ./dwm { inherit config lib pkgs; } ) ;

#  config = lib.mkIf is_dwm (import ./dwm { inherit config lib pkgs; } );
#  config = lib.mkIf is_gnome (import ./gnome { inherit config lib pkgs; } );

#  Turned off everything completely
#  config = lib.mkIf is_dwm (import ./dwm { inherit config lib pkgs; } ) // 
#           lib.mkIf is_gnome (import ./gnome { inherit config lib pkgs; } );
#  config = (lib.mkIf is_dwm (import ./dwm { inherit config lib pkgs; } )) //
#           (lib.mkIf is_gnome (import ./gnome { inherit config lib pkgs; } )) ;

  config = lib.mkMerge [
              (lib.mkIf is_dwm (import ./dwm { inherit config lib pkgs; } ))
              (lib.mkIf is_gnome (import ./gnome { inherit config lib pkgs; } ))
           ];


#  # Works
#  config = if true then module_dwm else 
#           if true then module_dwm else module_gnome;

#   config = if is_dwm then module_dwm else 
#            if is_gnome then module_gnome else { };
# 
}

