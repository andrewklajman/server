{ config, pkgs, nixvim, ... }:

# https://valentinpratz.de/posts/2024-02-12-nixvim-home-manager/

{
  imports = [ nixvim.homeManagerModules.nixvim ];

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

  programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      opts = {
        updatetime = 100; # Faster completion
        relativenumber = true; # Relative line numbers
        number = true; # Display the absolute line number of the current line
        hidden = true; # Keep closed buffer open in the background
      };
    };

#  programs.neovim = 
#  let
#    toLua = str: "lua << EOF\n${str}\nEOF\n";
#    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
#  in
#  {
#    enable = true;
#    vimdiffAlias = true;
#    extraLuaConfig = '' ${builtins.readFile ./nvim.init.lua} '';
#    plugins = with pkgs.vimPlugins; [
#      auto-pairs
#      context-vim
#      tabular
#      vim-markdown
#      vim-nix 
#    ];
#  };

# ## nvim init.lua
# -- https://martinlwx.github.io/en/config-neovim-from-scratch/#the-basics
# -- Options
# vim.g.mapleader = ','
# vim.g.maplocalleader = ','
# vim.o.number = true
# vim.o.relativenumber = true
# vim.o.tabstop = 4
# vim.o.shiftwidth = 4
# vim.o.termguicolors = true
# vim.o.linebreak = true
# vim.o.clipboard = 'unnamedplus'
# vim.o.cursorline = true
# 
# -- Netrw
# vim.g.netrw_banner = 0
# vim.g.netrw_liststyle = 3
# vim.g.netrw_winsize = 20
# vim.keymap.set('n','<leader>l',':Lexplore<CR>')
# 
# -- Netrw: Bookmarks
# -- * I feel like I need to come up with a better bookmarking solution.
# -- * I would like to have a bookmark folder with some symlinks created that I can just go to
# 
# -- Windows
# --   TODO: How to rotate windows
# --   TODO: How to move windows
# --   TODO: Splits from netrw
# vim.o.splitbelow = true
# vim.o.splitright = true
# 
# vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
# vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
# vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
# vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
# 
# vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
# vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
# vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
# vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
# 
# --Keybindings
# vim.keymap.set('n', '<leader>p', ':w<CR><Esc>:! ~/system_configuration/modules/dwm/xdotool.cr.sh<CR>', opts)


  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
