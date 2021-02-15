local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local api = vim.api

lsp_status.register_progress()

local custom_on_attach_diagnostics = function(_, bufnr)
  -- Mappings.

  local opts = {
    noremap=true,
    silent=true,
  }
  local function nmap_lsp(keys, cmd)
    api.nvim_buf_set_keymap(
      bufnr, 'n', keys, '<cmd>lua vim.lsp.'..cmd..'<CR>', opts
    )
  end
  nmap_lsp('D',     'diagnostic.show_line_diagnostics()')
  vim.g['diagnostic_enable_virtual_text'] = 1
end

local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, 'No location found')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local custom_on_attach = function(client, bufnr)
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.

  local opts = {
    noremap=true,
    silent=true,
  }
  local function nmap_lsp(keys, cmd)
    api.nvim_buf_set_keymap(
      bufnr, 'n', keys, '<cmd>lua vim.lsp.'..cmd..'<CR>', opts
    )
  end
  nmap_lsp('gd',    'buf.declaration()')
  nmap_lsp('<c-]>', 'buf.definition()')
  nmap_lsp('K',     'buf.hover()')
  nmap_lsp('D',     'diagnostic.show_line_diagnostics()')
  nmap_lsp('<C-k>', 'buf.signature_help()')
  nmap_lsp(',rn',   'buf.rename()')
  -- nmap_lsp('pd',    'buf.peek_definition()')
  api.nvim_buf_set_keymap(bufnr, 'n', 'pd', '<cmd>lua peek_definition()<cr>', opts)
  nmap_lsp('gr',    'buf.references()')
  nmap_lsp('a',     'buf.code_action()')
  vim.g['diagnostic_enable_virtual_text'] = 1
  -- api.nvim_set_var('diagnostic_enable_virtual_text','1')
  require'completion'.on_attach()
  lsp_status.on_attach(client)
end

--  efm doesn't like being told to fold, so only fold on buffers that
--  don't have EFM but use an LSP server that supports folding.
local custom_on_attach_folding = function(client, bufnr)
  custom_on_attach(client, bufnr)
  require('folding').on_attach()
end

lspconfig.clangd.setup{
    on_attach = custom_on_attach
}
