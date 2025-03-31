" globals
let g:mapleader = ","
let g:maplocalleader = ","
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

" options
set number
set relativenumber
set tabstop=5
set shiftwidth=2
set expandtab
set cursorline
set splitbelow
set splitright
set nowrap

" keymaps
map <leader>l :Lexplore<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Mardown folds
au BufEnter *.md setlocal foldexpr=MarkdownLevel()  
au BufEnter *.md setlocal foldmethod=expr   
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "=" 
endfunction
