local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

-- Function to setup the diagnostic LSP information.
local function setupDiagnostics()
  local signs = {

    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

setupDiagnostics()

-- Install the LSP Servers
lsp_installer.setup({
  ensure_installed = { 'tsserver', 'tailwindcss', 'pyright', 'html', 'sumneko_lua' },
  automatic_installation = false,
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗'
    }
  }
})

-- Bind function after LSP has been initialized.
local on_attach = function(client, bufnr)
  require('notify')('Buffer attached to LSP Server: ' .. client.name, 'success', {
    title = 'LSP Information'
  })

  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  -- Diagnostics Bindings
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'g[', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'ga', vim.diagnostic.setloclist, bufopts)

  vim.keymap.set('n', '<Space>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<C-a>', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<C-f>', vim.lsp.buf.formatting, bufopts)

  -- Remove formatting capabilities for some LSP servers
  local no_formatting_servers = { 'tsserver' }
  for _, c in ipairs(no_formatting_servers) do
    if c == client.name then
      client.resolved_capabilities.document_formatting = false
    end
  end

  -- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  --   pattern = { '*' },
  --   callback = vim.lsp.buf.formatting_sync,
  -- })
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Formatters
-- TODO: Break the null ls server into a separate plugin.
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

require 'lspconfig'.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    userLanguages = {
      htmldjango = 'html'
    }
  }
}

require 'lspconfig'.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'htmldjango' },
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
