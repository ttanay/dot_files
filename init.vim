" Redirect shada/state to ~/.local/share (writable) if ~/.local/state is not
" NOTE: permanent fix is: sudo chown -R $(whoami) ~/.local/state/
if !isdirectory(expand('~/.local/state/nvim'))
  set shadafile=~/.local/share/nvim/shada/main.shada
endif

" ============================================================
" Plugin Manager: vim-plug
" Install: https://github.com/junegunn/vim-plug
" Run :PlugInstall after opening Neovim for the first time
" ============================================================
call plug#begin(stdpath('data') . '/plugged')

    Plug 'preservim/nerdtree'                   " File Explorer on the left
    Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'               " Icons

    Plug 'vim-airline/vim-airline'              " Status bar at the bottom

    Plug 'chaoren/vim-wordmotion'               " Skip all types of words
    Plug 'tpope/vim-commentary'                 " Comment selection using 'gc'
    Plug 'jiangmiao/auto-pairs'                 " Add brackets in pairs
    Plug 'tpope/vim-surround'                   " Change surrounding pairs
    Plug 'gcmt/wildfire.vim'                    " Select nearest group
    Plug 'ntpeters/vim-better-whitespace'

    Plug 'joshdick/onedark.vim'                 " One Dark Pro colors
    Plug 'morhetz/gruvbox'                      " Gruvbox theme
    Plug 'NLKNguyen/papercolor-theme'           " High-contrast theme

    Plug 'sheerun/vim-polyglot'                 " Language Pack

    " LSP & completion (replaces YouCompleteMe + jedi-vim)
    Plug 'neovim/nvim-lspconfig'                " Default server configs for vim.lsp.config
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    Plug 'fatih/vim-go'                         " Golang
    Plug 'rhysd/vim-clang-format'               " Clang format

    Plug 'tpope/vim-fugitive'                   " Git plugin
    Plug 'lewis6991/gitsigns.nvim'              " Git markers in the side (replaces vim-gitgutter)

    " Telescope (replaces ctrlp)
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context' " Sticky function header (replaces context.vim)

    Plug 'lukas-reineke/indent-blankline.nvim'  " Indent line markers (replaces indentLine)

    Plug 'editorconfig/editorconfig-vim'        " EditorConfig support

    Plug 'MeanderingProgrammer/render-markdown.nvim' " Render markdown in the buffer

    Plug 'psf/black', { 'branch': 'stable' }

    Plug 'Julian/lean.nvim' "Lean

call plug#end()

filetype plugin indent on

" ============================================================
" General Settings
" ============================================================

set foldmethod=indent
set linebreak

syntax on
set mouse=a

set encoding=utf-8
set fileencodings=utf-8

set autoindent
set smartindent
set cindent
set background=dark
set expandtab
set smarttab
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
set number relativenumber
set nu rnu
set linespace=3
set backspace=indent,eol,start

" True color support (Neovim)
set termguicolors

set colorcolumn=80
highlight ColorColumn ctermbg=lightcyan

try
  colorscheme PaperColor
catch /E185/
  " Plugin not installed yet — run :PlugInstall
endtry
"colorscheme onedark

" ============================================================
" NERDTree
" ============================================================

let g:NERDTreeMapChangeRoot = "`"
let g:NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$', '\~$']
let NERDTreeShowLineNumbers = 1
let NERDTreeWinSize = 25

nmap <Leader>] :NERDTreeToggle<CR>
nnoremap <Space>c :NERDTreeCWD<CR>

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
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

" ============================================================
" vim-devicons
" ============================================================

let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1

" ============================================================
" Airline
" ============================================================

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ============================================================
" Clipboard
" ============================================================

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" ============================================================
" Window navigation
" ============================================================

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" New Tab
nmap <Leader>n :tabnew<CR>

" ============================================================
" Telescope (replaces ctrlp)
" ============================================================

nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <Leader>fg <cmd>Telescope live_grep<CR>
nnoremap <Leader>fb <cmd>Telescope buffers<CR>

" ============================================================
" Trailing whitespace
" ============================================================

fun! StripTrailingWhitespace()
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

" ============================================================
" Clang Format
" ============================================================

let g:clang_format#detect_style_file = 1
let g:clang_format_on_save = 1

function! FormatBuffer()
  if g:clang_format_on_save == 1 && &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format-18
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()

" ============================================================
" Go
" ============================================================

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

" ============================================================
" LSP + Completion (Lua config)
" ============================================================

lua << EOF
-- Guard: only run if plugins are installed
local ok_cmp, cmp = pcall(require, 'cmp')
local ok_snip, luasnip = pcall(require, 'luasnip')
if not (ok_cmp and ok_snip) then
  vim.notify('Run :PlugInstall to install plugins', vim.log.levels.WARN)
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<Tab>']     = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>']   = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- LSP servers (native vim.lsp.config API, Neovim 0.11+)
local ok_caps, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = ok_caps and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('clangd', { capabilities = capabilities })
vim.lsp.config('pyright', {  -- install: npm i -g pyright
  capabilities = capabilities,
})
vim.lsp.config('gopls', {   -- install: go install golang.org/x/tools/gopls@latest
  capabilities = capabilities,
})

vim.lsp.enable({ 'clangd', 'pyright', 'gopls' })

-- LSP keybindings (replaces YouCompleteMe mappings)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gt', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- gitsigns
local ok_gs, gitsigns = pcall(require, 'gitsigns')
if ok_gs then gitsigns.setup() end

-- treesitter (main branch API; parser install needs: npm i -g tree-sitter-cli)
local ts_langs = { 'c', 'cpp', 'go', 'python', 'lua', 'vim', 'markdown' }
local ok_ts, ts = pcall(require, 'nvim-treesitter')
if ok_ts then
  ts.install(vim.list_extend({ 'markdown_inline' }, ts_langs))
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ts_langs,
    callback = function() pcall(vim.treesitter.start) end,
  })
end

-- treesitter-context
local ok_ctx, tsctx = pcall(require, 'treesitter-context')
if ok_ctx then tsctx.setup({ enable = true }) end

-- indent-blankline
local ok_ibl, ibl = pcall(require, 'ibl')
if ok_ibl then ibl.setup() end

-- lean
vim.g.lean_config = {
  mappings = true,
  infoview = {
    autoopen = true,
  },
}
EOF
