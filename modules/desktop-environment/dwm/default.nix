{ config, lib, pkgs, ... }:

let
  passmenulogin = pkgs.writeShellScriptBin "passmenulogin" '' ${builtins.readFile ./passmenulogin} '';
  is_dwm = ( config.desktop-manager == "dwm" );
in
{
  fonts.packages = with pkgs; [ source-code-pro font-awesome ];
  environment.systemPackages = with pkgs; [ 
    dmenu 
    st 
    pass
    xclip
    passmenulogin 
  ];
  
  services = {
    xserver = {
      enable = true;
      windowManager.dwm.enable = true;
      xkb = {
        layout = "au"; 
        variant = "";
      };
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
      displayManager = {
        startx.enable = true;
        gdm.enable = true;
      };
    };
  };
  
  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        patches = [ 
          ./patch.st.1.vimhelp.dark.diff
          ./patch.st.2.font.dejavumono.diff
        ];
      });
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.xorg.libXext ];
        patches = [ 
          ./patch.dwm.2.switchtotag.diff
          ./patch.dwm.5.config.def.h.diff
        ];
      });
    })
  ];
}

