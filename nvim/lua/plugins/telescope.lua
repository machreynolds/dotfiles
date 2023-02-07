return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            -- require "tj.telescope.setup"
            -- require "tj.telescope.keys"
        end,
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-hop.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
