" globals
let g:mapleader = ","
let g:maplocalleader = ","
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

" options
set autoindent
set colorcolumn=90
set cursorline
set expandtab
set mouse=""
set nowrap
set number
set relativenumber
set shiftwidth=2
set splitbelow
set splitright
set tabstop=2
set textwidth=80
colorscheme catppuccin-frappe

" General folding functions
set foldclose=all        " Close folds if you leave them in any way
set foldcolumn=3         " Show the foldcolumn
set foldenable           " Turn on folding
set foldlevel=0          " Autofold everything by default
"set foldmethod=syntax " Fold on the syntax
set foldnestmax=1        " I only like to fold outer functions
set foldopen=all         " Open folds if you touch them in any way

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

" TaskWarrior tasks [ Modify, Add and Update tasks ]
au BufEnter *.md %!python3 scripts/task.py --update-task
nnoremap <leader>ta :.!python3 scripts/task.py --add-task<CR>
nnoremap <leader>tu :%!python3 scripts/task.py --update-task<CR>

" TaskWarrior reports [ Auto generate reports in taskreprots/ ]
autocmd BufEnter ~/Documents/notes/taskreports/*.report call TaskReport()
function! TaskReport()
   normal ggdG
   execute('r!python3 scripts/task_report.py '..expand('%:t:r'))
   w
endfunction

" init.vim folds
au BufEnter init.vim setlocal foldexpr=InitVimLevel()  
au BufEnter init.vim setlocal foldmethod=expr   
function! InitVimLevel()
    if getline(v:lnum) =~ '^" .*$'
        return ">1"
    endif
    return "=" 
endfunction

" Python Folding on functions
au BufEnter *.py setlocal foldexpr=PythonDefLevel()  
au BufEnter *.py setlocal foldmethod=expr   
function! PythonDefLevel()
    if getline(v:lnum) =~ '^def .*$'
        return ">1"
    endif
    return "=" 
endfunction
