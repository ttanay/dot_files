set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'preservim/nerdtree' "File Explorer on the left
    Plugin 'vim-airline/vim-airline' "Status bar at the bottom
    Plugin 'chaoren/vim-wordmotion' "Skip all types of words
    Plugin 'tpope/vim-commentary' "Comment selection using 'gc'
    Plugin 'jiangmiao/auto-pairs' "Add brackets in pairs
    Plugin 'tpope/vim-surround' "Change surrounding pairs
    Plugin 'gcmt/wildfire.vim' "Select nearest group
    Plugin 'Yggdroot/indentLine' "Display indent line markers
    "Plugin 'vim-scripts/wombat256.vim' "Color scheme
    Plugin 'joshdick/onedark.vim' "One Dark Pro! colors
    Plugin 'sheerun/vim-polyglot' "Language Pack
    "Plugin 'ryanoasis/vim-devicons' "Device Icons
    Plugin 'ycm-core/YouCompleteMe' "C/C++ code completion with clangd
    Plugin 'fatih/vim-go' "Golang
    Plugin 'rhysd/vim-clang-format' "Clang format
    Plugin 'tpope/vim-fugitive' "Git plugin
    Plugin 'airblade/vim-gitgutter' "Git markers in the side
"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Settings I liked from joom/vim-starter
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0 "change 0 to 1 if you have a powerline font
set laststatus=2
set t_Co=256
" }}}

" NERDTree {{{
let g:NERDTreeMapChangeRoot =  "`"

nmap <Leader>] :NERDTreeToggle<CR>
nnoremap <Space>c :NERDTreeCWD<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowLineNumbers = 1
let NERDTreeWinSize = 25

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
  "                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
        if (m[2] =~ '..a..')
            let windowfound = 1
        endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
" }}}

" General {{{

set nocompatible
filetype off
set foldmethod=indent
set linebreak

set number

syntax on
set mouse=a

filetype plugin indent on

set encoding=utf-8
set fileencodings=utf-8

set autoindent
set smartindent
set cindent
set background=dark
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set wildignore=*.pyc
set ignorecase
set smartcase
set hlsearch
set incsearch
set shiftround
set history=1000
set undolevels=1000
set noswapfile
set nobackup
set number
set linespace=3
set backspace=indent,eol,start

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" }}}

"System clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"New Tab
nmap <Leader>n :tabnew<CR>

set colorcolumn=80
highlight ColorColumn ctermbg=lightcyan

syntax on
colorscheme onedark
