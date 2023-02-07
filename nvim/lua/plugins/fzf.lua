return {
    { "junegunn/fzf", build = "./install --all", config = function()
        local map = vim.keymap.set
        -- Fuzzy ripgrep
        map('n', '<leader>/', '<cmd>Rg<cr>')
        map('n', '<leader>*', [[:execute 'Rg' '\b' . expand('<cword>') . '\b'<cr>]])
        map('x', '<leader>/', 'y:Rg <C-R>"<cr>')
        -- vim commands
        map('n', '<leader>c', '<cmd>Commands<cr>')
        -- Show maps
        map('n', '<leader>m', '<cmd>Maps<cr>')
        -- Find symbol of current document
        map('n', '<leader>o', '<cmd>BTags<cr>')
        -- List files
        map('n', '<leader>f', '<cmd>Files<cr>')
        -- List buffers
        map('n', '<leader>b', '<cmd>Buffers<cr>')
        -- Help
        map('n', '<leader>h', '<cmd>Helptags<cr>')
    end
    },
    { "junegunn/fzf.vim" },
}
