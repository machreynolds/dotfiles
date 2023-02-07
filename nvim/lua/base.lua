local opt = vim.opt
local g = vim.g

g.mapleader = " "

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.updatetime = 300
opt.backspace = { 'indent', 'eol', 'start' }

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- floating popup menu from command line completion
-- opt.pumblend = 17
opt.pumheight = 18
--opt.wildmenu = 'longest:full'
opt.wildoptions = "pum"
opt.cmdheight = 1

opt.relativenumber = true
opt.number = true

opt.hidden = true
opt.backup = false

opt.splitright = true
opt.splitbelow = true
opt.showmatch = true -- show matching brackets when text indicator is over them

opt.scrolloff = 10 -- keep lines below cursor

opt.belloff = "all"

opt.mouse = "a"

opt.autoindent = true
opt.cindent = true
opt.wrap = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.showcmd = true
opt.inccommand = 'split'

--
-- Disable bultin-plugins
--

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
