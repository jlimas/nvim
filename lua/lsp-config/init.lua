local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

-- Install the LSP Servers
lsp_installer.setup({
  ensure_installed = { 'tsserver', 'jsonls', 'pyright', 'html', 'sumneko_lua' },
  automatic_installation = false,
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗'
    }
  }
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', ',e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', ',q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- client, bufnr
local on_attach = function(client, bufnr)
  require('notify')('Buffer attached to LSP Server: ' .. client.name, 'success', {
    title = 'LSP Information'
  })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<Space>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<C-a>', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-f>', vim.lsp.buf.formatting, bufopts)

  -- Remove formatting capabilities for some LSP servers
  local no_formatting_servers = { 'tsserver' }
  for _, c in ipairs(no_formatting_servers) do
    if c == client.name then
      client.resolved_capabilities.document_formatting = false
    end
  end

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    callback = vim.lsp.buf.formatting_sync,
  })
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Formatters
local null_ls = require 'null-ls'
local formatting = null_ls.builtins.formatting
null_ls.setup({
  sources = {
    formatting.black,
    formatting.isort,
    formatting.prettierd
  }
})

require 'lspconfig'.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    provideFormatter = false
  }
}

require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          quote_style = 'single',
        }
      }
    },
  },
}
