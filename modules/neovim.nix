{ config, pkgs, lib, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
    	 customRC = lib.fileContents ./init.vim;
    };
  };

}
