return {
    {
        "morhetz/gruvbox",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    "tpope/vim-surround",
    "tpope/vim-repeat", -- Repeat actions better
    "tpope/vim-abolish", -- Cool things with words!
    "romainl/vim-qf",
    "nvim-lua/plenary.nvim",
    "folke/neodev.nvim",
    "SmiteshP/nvim-navic",
    {
        "mhinz/vim-startify",
        config = function()
            vim.g.startify_change_to_vcs_root = 1

            local map = vim.keymap.set
            map('n', '<leader>s', '<cmd>Startify<cr>')
        end,
    },
    {
        "kosayoda/nvim-lightbulb",
        opts = {
            autocmd = { enabled = true }
        },
    },
}
