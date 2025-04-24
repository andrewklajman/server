{ config, pkgs, lib, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
    	 customRC = lib.fileContents ./init.vim;
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ 
#          lazy-nvim
          ctrlp-vim            # https://github.com/ctrlpvim/ctrlp.vim/
          catppuccin-nvim     # https://github.com/catppuccin/nvim/
          vim-fugitive        # Git management
        ];
        opt = [ ];
      }; 
    };
    withNodeJs = true;
  };

# https://nixalted.com/




}
