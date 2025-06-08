{ config, pkgs, ... }:
  
# https://valentinpratz.de/posts/2024-02-12-nixvim-home-manager/

{
  home = {
    username = "andrew";
    homeDirectory = "/home/andrew";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.git = {
    enable = true;
    userName = "andrew";
    userEmail = "andrew.klajman@gmail.com";
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
