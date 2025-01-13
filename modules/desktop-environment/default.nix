{ config, lib, pkgs, ... }:

{
  options.dwm.enable = lib.mkEnableOption "dwm";

  config = lib.mkIf config.dwm.enable {
    fonts.packages = with pkgs; [ source-code-pro font-awesome ];
    environment.systemPackages = with pkgs; [ dmenu st ];

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
            ./patch.st.1.catppuccin.mocha.diff
            ./patch.st.2.font.source_code_pro.diff
          ];
        });
        dwm = super.dwm.overrideAttrs (oldAttrs: rec {
          buildInputs = oldAttrs.buildInputs ++ [ pkgs.xorg.libXext ];
          patches = [ 
            ./patch.dwm.2.switchtotag.diff
            ./patch.dwm.3.config.def.h.diff
          ];
        });
      })
    ];
  };
}

