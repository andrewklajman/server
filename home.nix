{ config, pkgs, ... }:

{
  home = {
    username = "andrew";
    homeDirectory = "/home/andrew";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # home.packages = with pkgs; [ ];

  programs.git = {
    enable = true;
    userName = "andrew";
    userEmail = "andrew.klajman@gmail.com";
  };

  programs.starship.enable = false;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
