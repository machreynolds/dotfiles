local api = vim.api
local lsp = vim.lsp

local M = {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
}

function M.config()
    require('neodev').setup({
        snippet = true,
    })

    local au_group = api.nvim_create_augroup('lsp_aucmds', {})

    local function on_attach(client, bufnr)

        local function buf_map(mode, lhs, rhs)
            local map = vim.keymap.set
            map(mode, lhs, rhs, { buffer = true, silent = true })
        end

        local builtins = require('telescope.builtin')
        --buf_map('n', 'gD', builtins.lsp_declarations)
        buf_map('n', 'gd', builtins.lsp_definitions)
        buf_map('n', 'gi', builtins.lsp_implementations)
        buf_map('n', 'gTD', builtins.lsp_type_definitions)
        buf_map('n', 'gr', builtins.lsp_references)
        buf_map('n', 'gws', builtins.lsp_workspace_symbols)

        buf_map('n', 'K', lsp.buf.hover)
        buf_map('n', '<leader>a', lsp.buf.code_action)
        buf_map('n', '<leader>rn', lsp.buf.rename)
        buf_map('n', ']e', vim.diagnostic.goto_next)
        buf_map('n', '[e', vim.diagnostic.goto_prev)

        buf_map({ 'n', 'i', 's' }, '<C-g>', lsp.buf.signature_help)

        if client.server_capabilities.documentFormattingProvider then
            buf_map('n', '<leader>=', lsp.buf.format)
        end

        if client.server_capabilities.documentRangeFormattingProvider then
            buf_map('x', '<leader>=', lsp.buf.format)
        end

        if client.server_capabilities.documentHighlightProvider then
            api.nvim_create_autocmd('CursorHold', {
                group = au_group,
                buffer = bufnr,
                callback = lsp.buf.document_highlight,
                desc = 'lsp.buf.document_highlight',
            })
            api.nvim_create_autocmd('CursorMoved', {
                group = au_group,
                buffer = bufnr,
                callback = lsp.buf.clear_references,
                desc = 'lsp.buf.clear_references',
            })
        end

        if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufnr)
        end
    end

    local servers = {
        clangd = {
            cmd = { 'clangd', '--header-insertion=never' },
            init_options = {
                clangdFileStatus = true,
                fallbackFlags = { '-std=c++20' },
            },
        },
        pyright = {},
        sumneko_lua = {
            cmd = { 'lua-language-server' },
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        },
        rust_analyzer = {
            cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
        },
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for client, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = vim.tbl_deep_extend(
            'keep',
            config.capabilities or {},
            capabilities
        )
        require('lspconfig')[client].setup(config)
    end

end

return M
