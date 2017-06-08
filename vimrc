set nocompatible    
filetype off       
syntax on

set autoindent
set expandtab 
set shiftwidth=4
set softtabstop=4

set t_Co=256
set encoding=utf-8

" remove unpleasant pipes from vertical splits
set fillchars+=vert:\

set showmode 
set laststatus=2
set wildmenu

set number 
set nowrap 
set relativenumber
set cursorline
set cursorcolumn
set showmatch "Light {}[]()

" for plugins like powerline
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

"================================================================"
"                              Maps                              "
"================================================================"

map <C-E> :NERDTreeToggle<CR>
map <C-T> :TagbarToggle<CR>
map <f5> :GundoToggle<CR>

"================================================================"
"                         Plugins:Plug                           "
"================================================================"
call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'sjl/gundo.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'
Plug 'shougo/neocomplete.vim'

"Plug 'arcticicestudio/nord-vim'
"Plug 'tyrannicaltoucan/vim-quantum'
"Plug 'dracula/vim'
Plug 'flazz/vim-colorschemes'

Plug 'mattn/emmet-vim'

call plug#end()

"----------------------------------------------------------------"
"                           syntastic                            "

"set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_w = 1
let g:syntastic_check_on_wq = 0

"----------------------------------------------------------------"
"                          neocomplete                           "

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

"----------------------------------------------------------------"
"                          ctrlP.vim                             "

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_working_path_mode = 'ra'

"----------------------------------------------------------------"
"                           NERDTree                             "
"Change default arrows
let g:NERDTreeDirArrowExpandable = '◉'
let g:NERDTreeDirArrowCollapsible = '○'

"open automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"----------------------------------------------------------------"
"                 vim-nerdtree-syntaz-highlight                  "

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

"----------------------------------------------------------------"
"                     vim-nerdtree-indicator                     "
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"----------------------------------------------------------------"
"                          vim-airline                           "
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

color Tomorrow-Night-Bright 
