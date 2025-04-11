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
set mouse=""
set colorcolumn=90
colorscheme catppuccin-frappe


" keymaps
map <leader>l :Lexplore<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap z<CR> z<CR>2k2j

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

" gf alternative (open or create new link)
autocmd BufEnter *.md inoremap <leader>wf <Esc>:call OCloneFile()<CR>
function! OCloneFile()
    normal viW"ay
    if filereadable(@a)
         execute('edit '..@a)
    else
         execute('new '..@a)
    endif
endfunction

" ctrl-p Setup
autocmd BufEnter *.md nnoremap <leader>wcp :CtrlP /home/andrew/Documents/notes<CR>


" Cycle through color
let g:colors = getcompletion('', 'color')
nnoremap <leader>cn :let next_color='colorscheme '..NextColors()<CR>:execute next_color<CR>:echo next_color<CR>
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc

" TaskWarrior notes
" #au BufEnter *.md py print('test')
au BufEnter *.md %!python3 scripts/task.py --update-task
nnoremap <leader>tm :.!python3 scripts/task.py --modify-task<CR>
nnoremap <leader>ta :.!python3 scripts/task.py --add-task<CR>
nnoremap <leader>tu :%!python3 scripts/task.py --update-task<CR>

