local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
}

function M.config()
    local navic = require("nvim-navic")
    require("lualine").setup({
        theme = 'gruvbox',
        sections = {
            lualine_c = { { 'filename', file_status = true, path = 0 }, { navic.get_location, cond = navic.is_available }, }
        }
    })
end

return M
