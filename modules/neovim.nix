{ config, pkgs, lib, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
    	 customRC = lib.fileContents ./init.vim;
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ 
#          coc-fzf             # https://github.com/antoinemadec/coc-fzf/ 
#            fzf-vim           # https://github.com/junegunn/fzf.vim/?tab=readme-ov-file
#            coc-nvim          # https://github.com/neoclide/coc.nvim/

#          nvim-fzf-commands   # https://github.com/vijaymarupudi/nvim-fzf-commands/
#          nvim-fzf            # https://github.com/vijaymarupudi/nvim-fzf/
          ctrlp-vim            # https://github.com/ctrlpvim/ctrlp.vim/
          lazy-nvim
          catppuccin-nvim     # https://github.com/catppuccin/nvim/
        ];
        opt = [ ];
      }; 
    };
    withNodeJs = true;
  };

# https://nixalted.com/




}
