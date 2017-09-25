let g:loaded_python_provider = 1 " disable python2
let g:python3_host_prog = "/home/swallace/packages/Python-3.6.0/bin/python3"
let g:ycm_server_python_interpreter = "/home/swallace/packages/Python-3.6.0/bin/python3"
set guicursor=

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'Valloric/YouCompleteMe', { 'do': 'export EXTRA_CMAKE_ARGS=\"-DPYTHON_EXECUTABLE=/opt/bats/bin/python -DPYTHON_LIBRARIES=/opt/bats/lib/libpython2.7.so -DPATH_TO_LLVM_ROOT=/home/swallace/tmp/llvm-install -DEXTRA_RPATH=/opt/bats/lib64\"; ./install.py --clang-completer' }
Plug 'Valloric/YouCompleteMe', { 'do': 'export EXTRA_CMAKE_ARGS=\"-DPYTHON_EXECUTABLE=/home/swallace/packages/Python-3.6.0/bin/python3 -DPYTHON_LIBRARIES=/home/swallace/packages/Python-3.6.0/lib/libpython3.6.so -DPATH_TO_LLVM_ROOT=/home/swallace/tmp/llvm-install -DEXTRA_RPATH=/opt/bats/lib64:/home/swallace/packages/Python-3.6.0/lib\"; python3 ./install.py --clang-completer' }
Plug 'kien/ctrlp.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machreynolds/custom-snippets'
Plug 'katonori/cxxtags-vim'
Plug 'davidhalter/jedi-vim'
Plug 'benmills/vimux'
Plug 'pitluga/vimux-nose-test'
Plug 'janko-m/vim-test'
Plug 'lyuts/vim-rtags'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/denite.nvim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'dhruvasagar/vim-table-mode'
"Plug expand('file://$HOME/git_checkouts/vim-bats-waf')
"Plug 'git@scodevtls:pub/swallace/vim-bats-waf'

call plug#end()

set nohlsearch
set hidden

set makeprg=cmake\ --build\ /opt/ecn/users/swallace/build\ --\ -j64\ 2\>\&1\|\ egrep\ -v\ '^ICECC\|\ note:'

colorscheme jellybeans

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"let g:ctrlp_use_caching = 0
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
\ }

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" select just pasted text
nnoremap gp `[v`]

" Make opening of files in the same directory easier, and use %% in command
" mode to expand the directory of the current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Bubble multiple lines
vnoremap <C-Up> xkP`[V`]
vnoremap <C-Down> xp`[V`]

"Ex mode is useless, let us quit the application:
map Q :qa<CR>

"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'info'
"let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_goto_buffer_command = 'vertical-split'
let g:ycm_always_populate_location_list = 1
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_cache_omnifunc = 1
"let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_min_num_identifier_candidate_chars = 0
"let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
"let g:ycm_semantic_triggers = {
"  \   'c,objc' : ['->', '.'],
"  \   'cpp,objcpp' : ['->', '.', '::'],
"  \   'ocaml' : ['.', '#'],
"  \   'perl' : ['->'],
"  \   'php' : ['->', '::'],
"  \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
"  \   'ruby' : ['.', '::'],
"  \   'lua' : ['.', ':'],
"  \   'erlang' : [':'],
"  \ }
"let g:ycm_filetype_whitelist = { 'c': 1, 'cpp': 1, 'cmake': 1 }
"let g:ycm_filetype_whitelist = { 'c': 1, 'cpp': 1, 'python': 1, 'cmake': 1 }
let g:ycm_collect_identifiers_from_tags_files = 1

" YouCompleteMe
" reference: [ycm-jedi-vim]
" jedi-vim {
  let g:jedi#force_py_version=3
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#completions_enabled = 0
  let g:jedi#completions_command = ""
  let g:jedi#show_call_signatures = "1"

  let g:jedi#goto_assignments_command = "<leader>pa"
  let g:jedi#goto_definitions_command = "<leader>pd"
  let g:jedi#documentation_command = "<leader>pk"
  let g:jedi#usages_command = "<leader>pu"
  let g:jedi#rename_command = "<leader>pr"
" }

nnoremap <leader>j :YcmCompleter GoTo<CR>
nnoremap <leader>f :YcmCompleter GoToDefinition<CR>
nnoremap <leader>c :YcmCompleter GoToDeclaration<CR>

let g:UltiSnipsEditSplit = "vertical"
"let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsDontReverseSearchPath = "1"
let g:UltiSnipsDoHash = 1

" c style comments using *
let g:surround_42 = "/*\r*/"

let g:tmuxline_theme = 'jellybeans'

let g:airline_theme = 'jellybeans'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'

let g:airline#extensions#bufferline#enabled = 1

au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set incsearch
set ignorecase
set smartcase

au FileType make set noexpandtab
"au FileType python set noexpandtab
au FileType gitcommit set spell

let test#strategy = "dispatch"

map <leader>= :py3f ~/bin/clang-format.py<cr>
imap <leader>= <c-o>:py3f ~/bin/clang-format.py<cr>

" allow repeating in visual mode
vnoremap . :norm.<CR>

autocmd FileType cpp setlocal commentstring=//\ %s
