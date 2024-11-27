set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required Plugin 'VundleVim/Vundle.vim'
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
    Plugin 'pechorin/any-jump.vim' "Go-to-def/ref
    Plugin 'PhilRunninger/nerdtree-visual-selection' "Visual mode for NERDTree
    Plugin 'Eliot00/git-lens.vim' "gitlens for vim
    Plugin 'ctrlpvim/ctrlp.vim' "ctrl+p file finder like vscode
    Plugin 'wellle/context.vim' "Sticky function header
    Plugin 'editorconfig/editorconfig-vim' "editorconfig support for vim
    Plugin 'morhetz/gruvbox' "light mode is nice of this theme
    Plugin 'ntpeters/vim-better-whitespace'
    Plugin 'ryanoasis/vim-devicons' "icons
    "Plugin 'KabbAmine/zeavim.vim' "Zeal viewer in vim
"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:GIT_LENS_ENABLED = 1

" Settings I liked from joom/vim-starter
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 "change 0 to 1 if you have a powerline font
"set laststatus=2
"set t_Co=256
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"
"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = 'Ɇ'
"let g:airline_symbols.whitespace = 'Ξ'
"
"" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''
" }}}

" NERDTree {{{
let g:NERDTreeMapChangeRoot =  "`"
let g:NERDTreeShowHidden = 1

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


"vim-devicons
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1


" General {{{

set nocompatible
filetype off
set foldmethod=indent
set linebreak

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
"set shiftwidth=4
"set softtabstop=4
"set tabstop=4
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
set relativenumber


fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

" Remove trailing whitespace on save
autocmd BufWritePre * call StripTrailingWhitespace()
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

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
"let g:clang_format_on_save = 1
"" Run clang-format on save
"" https://vi.stackexchange.com/questions/21102/how-to-clang-format-the-current-buffer-on-save
"function FormatBuffer()
"  if g:clang_format_on_save == 1 && &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
"    let cursor_pos = getpos('.')
"    :%!clang-format-18
"    call setpos('.', cursor_pos)
"  endif
"endfunction

"autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()

" Keybindings for YouCompleteMe
nmap gt :YcmC GoTo<CR>
nmap gr :YcmC GoToReferences<CR>
nmap gh :YcmC GoToInclude<CR>
