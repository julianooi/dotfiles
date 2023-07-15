local lsp = require('lsp-zero').preset({})

local on_attach = function(client, bufnr)
  local opts = {buffer = bufnr}
  local bind = vim.keymap.set

  lsp.default_keymaps({
    buffer = bufnr,
    omit = {'gi','go','gr','gd','<C-k>'},
    preserve_mappings = false,
  })
  bind('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
  bind('n', 'go', '<cmd>Telescope lsp_type_definitions<cr>', opts)
  bind('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
  bind('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  bind('n', '<C-p>', vim.lsp.buf.signature_help, opts)
  bind('i', '<C-p>', vim.lsp.buf.signature_help, opts)
  bind('n', '<leader>pl', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function() 
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end,
        buffer = bufnr,
        group = "lsp_document_highlight",
        desc = "Clear All the References",
    })
  end
end


require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,
    volar = function()
      require('lspconfig').volar.setup {
        filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
      }
    end,
    yamlls = function()
      require('lspconfig').yamlls.setup {
        settings = {
          yaml = {
            keyOrdering = false,
          }
        }
      }
    end,
    gopls = function()
      require('lspconfig').gopls.setup {
        settings = {
          gopls = {
            gofumpt = true
          }
        }
      }
    end,
    terraformls = function()
      require('lspconfig').terraformls.setup {
        filetypes = {'tf'}
      }
    end
  },
})

lsp.extend_cmp()
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({

})

lsp.on_attach(on_attach)
lsp.setup()
 
-- Flutter setupfunction()
require('flutter-tools').setup {
  widget_guides = {
    enabled = true,
  },
  lsp = {
    color = {
      enabled = true,
    },
    on_attach = on_attach,
  }
}
require('telescope').load_extension('flutter')
