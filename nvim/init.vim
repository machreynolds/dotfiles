" General Settings
" ================

set encoding=utf-8
scriptencoding utf-8
filetype plugin on
set updatetime=300
set backspace=indent,eol,start
set ignorecase
set smartcase
set wildmenu
set wildmode=longest:full,full
set wildoptions+=pum
set mouse=a
set lazyredraw
set regexpengine=2
" set undofile
" set undolevels=2000
set diffopt=vertical
set pumheight=18
set scrolloff=3
set cmdheight=2  " Useful for diagnostics
set number  " Show line number column
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
set relativenumber
"set signcolumn=yes  " for vim-pandoc-syntax and vim-signify
set splitright " open vnew windows to the right
set nowrap

"" Default formatting when not detected
set smartindent
set shiftwidth=4
set tabstop=4
set hidden

" Spellfile
set spellfile=~/.config/nvim/spell/en.utf-8.add

let g:python3_host_prog="$XDG_DATA_HOME/venv/nvim/bin/python3"

" =======
" Plugins
" =======

call plug#begin()
Plug 'junegunn/vim-plug'

" General plugins
" ~~~~~~~~~~~~~~~
Plug 'tpope/vim-surround'  " Commands for matching pairs
Plug 'tpope/vim-endwise' " auto-add 'endif', 'end', 'endfunction', etc.
Plug 'townk/vim-autoclose'  " Auto-match pairs in insert mode
Plug 'tpope/vim-commentary'  " Polygot keybinds for commenting code
Plug 'tpope/vim-abolish' " :Subvert command
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired' " quickfix navigation maps ]q, [q etc.
Plug 'ConradIrwin/vim-bracketed-paste'  " Auto-sets paste
Plug 'terryma/vim-expand-region' " syntax-aware expansion of visually-selected area
Plug 'ntpeters/vim-better-whitespace'
Plug 'romainl/vim-qf'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" More powerful/sophisticated plugins
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'rhysd/git-messenger.vim' " git blame in a floating window
Plug 'mhinz/vim-signify' " display VCS diff in signcolumn and navigate VCS chunks
" Neovim's builtin LSP and treesitter impl. make it a very lightweight IDE
Plug 'neovim/nvim-lspconfig' " The most important plugin
Plug 'nvim-lua/diagnostic-nvim' " wrap LSP diagnostic config
Plug 'pierreglaser/folding-nvim', { 'for': ['lua', 'c', 'cpp', 'go'] } " LSP-powered folding
Plug 'nvim-lua/lsp-status.nvim'  " lsp items in the statusbar
Plug 'nvim-treesitter/nvim-treesitter' " tree-sitter support
Plug 'tree-sitter/tree-sitter-cpp'
" Completion sources
Plug 'nvim-treesitter/completion-treesitter' " tree-sitter source for completion-nvim
Plug 'tpope/vim-dispatch' " async dispatch commands e.g. :Make
Plug 'vimwiki/vimwiki'
Plug 'liuchengxu/vista.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" FZF
" ~~~
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Telescope
" ~~~~~~~~~
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" Appearance Plugins
" ~~~~~~~~~~~~~~~~~~
Plug 'ryanoasis/vim-devicons'  " File icons: works with vim-airline.
Plug 'vim-airline/vim-airline'  " Like powerline
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-startify'

" Syntax highlighting
" ~~~~~~~~~~~~~~~~~
Plug 'norcalli/nvim-colorizer.lua' " Fastest color-code colorizer

Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" ==========
" Appearance
" ==========

" Use 24-bit (true-color) mode in Vim/Neovim
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more.)
if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if has('termguicolors')
    set termguicolors
endif
if has('transparency')
    set transparency=10
endif

let g:one_allow_italics = 1

hi Comment gui=italic
if !has('gui_running')
    " Use terminal emulator's background
    hi Normal guibg=NONE
endif

colorscheme gruvbox
"
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'short_path'

let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" :terminal colors
" ~~~~~~~~~~~~~~~~

set t_ut=
" black
let g:terminal_color_0 = '#31363b'
let g:terminal_color_8 = '#6a6e71'

" red
let g:terminal_color_1 = '#ed1515'
let g:terminal_color_9 = '#c0392b'

" green
let g:terminal_color_2 = '#11d116'
let g:terminal_color_10 = '#1cdc9a'

" yellow
let g:terminal_color_3 = '#f67400'
let g:terminal_color_11 = '#fdbc4b'

" blue
let g:terminal_color_4 = '#1d99f3'
let g:terminal_color_12 = '#3daee9'

" magenta
let g:terminal_color_5 = '#9b59b6'
let g:terminal_color_13 = '#8e44ad'

" cyan
let g:terminal_color_6 = '#1abc9c'
let g:terminal_color_14 = '#16a085'

" white
let g:terminal_color_7 = '#eff0f1'
let g:terminal_color_15 = '#ffffff'

" nvim-lsp

lua << EOF
require('lsp')
require('colorizer_settings')
require('treesitter')
require('completion')
EOF

" =========
" Functions
" =========

" Easily switch conceal levels
function! SwitchConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=1
    elseif &conceallevel == 1
        setlocal conceallevel=2
    elseif &conceallevel == 2
        setlocal conceallevel=0
    endif
endfunction

" ============
" Gen. Keymaps
" ============

nnoremap Q <Nop>

let mapleader = ' '
" hide search
nmap <silent> <leader><Space> :nohls<CR>
" If hiding search wasn't enough for you
nnoremap <silent> <C-l> :nohl<CR> :redraw<CR>
" Indent entire document with eqcmd. Alternative to :Format
nnoremap <F7> :Format<CR>:let b:winview = winsaveview()<CR>gg=G:call winrestview(b:winview)<CR>:w<CR>
" Toggle conceal level
nnoremap <silent> <C-c><C-y> :call SwitchConcealLevel() <CR>
" Toggle invisible chars
nnoremap <leader>l :set list!<CR>


" Completions
" ~~~~~~~~~~~
" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Auto close popup menu when finish completion
augroup completionstuff
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

let g:completion_trigger_on_delete = 1

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" completion chains
let g:completion_chain_complete_list = {
            \'default' : {
            \   'default' : [
            \       {'complete_items' : ['lsp', 'snippet', 'buffer']},
            \       {'mode' : 'file'}
            \   ],
            \   },
            \}

" keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

" Navigation
" ~~~~~~~~~~

" Use `[d` and `]d` for navigate diagnostics
nnoremap <silent> ]d :NextDiagnostic<CR>
nnoremap <silent> [d :PrevDiagnostic<CR>
nnoremap <silent> <leader>do :OpenDiagnostic<CR>

" fzf.vim
" ~~~~~~~

" Fuzzy ripgrep
nnoremap <silent> <space>/  <cmd>Rg<cr>
nnoremap <silent> <space>*  :execute 'Rg' '\b' . expand('<cword>') . '\b'<cr>
xnoremap <silent> <space>/  y:Rg <C-R>"<cr>
" vim commands
nnoremap <silent> <space>c  <cmd>Commands<cr>
" Show maps
nnoremap <silent> <space>m  <cmd>Maps<CR>
" Find symbol of current document
nnoremap <silent> <space>o  <cmd>BTags<cr>
" Search workspace symbols
nnoremap <silent> <space>s  <cmd>Tags<cr>
" List files
nnoremap <silent> <space>f  <cmd>Files<cr>
" List buffers
nnoremap <silent> <space>b  <cmd>Buffers<cr>
" Help
nnoremap <silent> <space>h  <cmd>Helptags<cr>

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" imap <leader><tab> <plug>(fzf-maps-i)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Make opening of files in the same directory easier, and use %% in command
" mode to expand the directory of the current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" delete without yanking
vnoremap <leader>d "_d
nnoremap <leader>d "_d

" replace currently selected text with default register without yanking
vnoremap <leader>p "_dP

" allow repeating in visual mode
vnoremap . :norm.<CR>

" select just pasted text
nnoremap gp `[v`]

nnoremap <silent> <leader>s  <cmd>Startify<CR>
let g:startify_change_to_vcs_root = 1

let g:AutoCloseExpandSpace = 0

noremap <leader>= :py3f clang-format.py<cr>

packadd termdebug
tnoremap <Esc><Esc> <C-\><C-n>

" Sizing window horizontally
nnoremap <A-m> <C-W><
nnoremap <A-/> <C-W>>
" Sizing window vertically
nnoremap <A-,> <C-W>+
nnoremap <A-.> <C-W>-

autocmd FileType cpp setlocal commentstring=//\ %s

let g:vista_default_executive = 'nvim_lsp'
nnoremap <leader>vd <cmd>Vista finder fzf:nvim_lsp<CR>
nnoremap <leader>vv <cmd>Vista!!<CR>

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'vim-vsnip'
