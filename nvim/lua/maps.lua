local keymap = vim.keymap
local map = keymap.set

-- Move to a window by using its window number.
for i = 1, 9 do
  map('n', 'w' .. i, i .. '<C-w><C-w>')
end

-- insert completion.
map('i', '<c-f>', '<c-x><c-f>')

-- disable ex mode
map('n', 'Q', '<Nop>')

-- hide search
map('', '<leader><Space>', ':nohls<cr>')
map('n', '<C-l>', ':nohl<cr> :redraw<cr>')
-- Toggle invisible chars
map('n', '<leader>l', ':set list!<cr>')

-- keep text selected after indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

-- copy to clipboard
map('v', '<leader>y', '"+y')
map('n', '<leader>y', '"+y')

-- delete without yanking
map('v', '<leader>d', '"_d')
map('n', '<leader>d', '"_d')

-- replace currently selected text with default register without yanking
map('v', '<leader>p', '"_dP')

-- allow repeating in visual mode
map('v', '.', ':norm.<cr>')

-- select just pasted text
map('n', 'gp', '`[v`]')

-- Make opening of files in the same directory easier, and use %% in command
-- mode to expand the directory of the current file.
--vim.api.nvim_set_keymap('c', '%%', [[<C-R>=expand('%:h').'/'<cr>]], { noremap = true })
map('c', '%%', [[<C-R>=expand('%:h').'/'<cr>]], { noremap = true })

-- map('', '<leader>=', ':py3f clang-format.py<cr>')
