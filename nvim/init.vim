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
set undofile
set undolevels=2000
set diffopt=vertical
set pumheight=18
set scrolloff=3
set cmdheight=2  " Useful for diagnostics
set number  " Show line number column
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" set relativenumber
set signcolumn=yes  " for vim-pandoc-syntax and vim-signify
set splitright " open vnew windows to the right

"" Default formatting when not detected
set smartindent
set shiftwidth=4
set tabstop=4
set hidden

" Spellfile
set spellfile=~/.config/nvim/spell/en.utf-8.add

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
Plug 'tpope/vim-fugitive'
Plug 'ConradIrwin/vim-bracketed-paste'  " Auto-sets paste
Plug 'terryma/vim-expand-region' " syntax-aware expansion of visually-selected area

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
" Completion sources
Plug 'nvim-lua/completion-nvim' " sets up async autocomplete for LSP
Plug 'nvim-treesitter/completion-treesitter' " tree-sitter source for completion-nvim
Plug 'steelsojka/completion-buffers' " buffer source for completion-nvim
" FZF
" ~~~
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Appearance Plugins
" ~~~~~~~~~~~~~~~~~~
Plug 'ryanoasis/vim-devicons'  " File icons: works with vim-ariline.
Plug 'vim-airline/vim-airline'  " Like powerline
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'

" Syntax highlighting
" ~~~~~~~~~~~~~~~~~
Plug 'norcalli/nvim-colorizer.lua' " Fastest color-code colorizer

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

" set cursorline  " Commented out because it slows (n)vim down.
if exists('&pumblend')
	set pumblend=15
	set winblend=10
	hi PmenuSel blend=10
endif

let g:one_allow_italics = 1

hi Comment gui=italic
if !has('gui_running')
	" Use terminal emulator's background
	hi Normal guibg=NONE
endif

colorscheme jellybeans
"
let g:airline_theme = 'jellybeans'
let g:airline_powerline_fonts = 1

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

" 'Ex mode is fucking dumb' --sircmpwm
nnoremap Q <Nop>

let mapleader = ','  " better than backslash imo
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

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" completion chains
let g:completion_chain_complete_list = {
			\'default' : {
			\	'default' : [
			\		{'complete_items' : ['lsp', 'snippet', 'buffer']},
			\		{'mode' : 'file'}
			\	],
			\	},
			\'c' : [
			\	{'complete_items': ['ts', 'lsp', 'snippet']}
			\	],
			\'python' : [
			\	{'complete_items': ['ts', 'lsp', 'snippet']}
			\	],
			\'lua' : [
			\	{'complete_items': ['ts', 'lsp', 'snippet']}
			\	],
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
