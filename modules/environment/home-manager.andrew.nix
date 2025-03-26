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
    globals = {
      mapleader = ",";
      maplocalleader = ",";
      netrw_banner = 0;
      netrw_liststyle = 3;
      netrw_winsize = 20;
    };
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      cursorline = true;
      splitbelow = true;
      splitright = true;
      wrap = false;
    };

    keymaps = [
      { key = "<leader>l"; action = ":Lexplore<CR>"; }
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; }
      { mode = "n"; key = "<C-Up>"; action = ":resize -2<CR>"; }
      { mode = "n"; key = "<C-Down>"; action = ":resize +2<CR>"; }
      { mode = "n"; key = "<C-Left>"; action = ":vertical resize -2<CR>"; }
      { mode = "n"; key = "<C-Right>"; action = ":vertical resize +2<CR>"; }

      { mode = "n"; key = "<leader>g"; action = ":Git"; }
      { mode = "n"; key = "<leader>ga"; action = ":Git add .<CR>"; }
      { mode = "n"; key = "<leader>gs"; action = ":Git status<CR>"; }
      { mode = "n"; key = "<leader>gl"; action = ":Git log --oneline --graph<CR>"; }
      { mode = "n"; key = "<leader>gc"; action = ":Git commit -m ''<C-F>hi"; }

    ];

    plugins = {
#      pkgs.vimPlugins.vimwiki;
      fugitive.enable = true;
      vimwiki.enable = true;
#      vimwiki.enable = true;
#      auto-pairs.enable = true;
#      context-vim.enable = true;
#      tabular.enable = true;
#      vim-markdown.enable = true;
#      vim-nix.enable = true;
    };

#     extraPlugins = [
# #      ( pkgs.vimUtils.buildVimPlugin {
# #          name = "my-plugin";
# #          src = pkgs.fetchFromGitHub {
# #            owner = "<owner>";
# #            repo = "<repo>";
# #            rev = "<commit hash>";
# #            hash = "<nix NAR hash>";
# #          };
# #        })
# 
# #      ( pkgs.vimUtils.buildVimPlugin {
# #          name = "vim-easygrep";
# #          src = pkgs.fetchFromGitHub {
# #            owner = "dkprice";
# #            repo = "vim-easygrep";
# #            rev = "d0c36a77cc63c22648e792796b1815b44164653a";
# #            hash = "sha256-bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=";
# #          };
# #        })
# 
#       ( pkgs.vimUtils.buildVimPlugin {
#           name = "vimwiki";
#           src = pkgs.fetchFromGitHub {
#             owner = "vimwiki";
#             repo = "vimwiki";
#             rev = "d0c36a77cc63c22648e792796b1815b44164653a";
#             hash = "sha256-bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=";
#           };
# fde35bb87e45abe930eebef5ab99a16289e53789
#         })
#     ];

  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
