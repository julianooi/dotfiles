local lsp = require('lsp-zero').preset({
  name = 'recommended',
  set_lsp_keymaps = {
    omit = {'gi','go','gr','gd','<C-k>'},
    preserve_mappings = false,
  },
})

lsp.setup_nvim_cmp({
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'path'},
    {name = 'buffer', keyword_length = 3},
  },
})

-- volar config
lsp.configure('volar', {
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
})

-- yamlls
lsp.configure('yamlls', {
  settings = {
    yaml = {
      keyOrdering = false,
    }
  }
})

-- go config
lsp.configure('gopls', {
  settings = {
    gopls = {
      gofumpt = true
    }
  }
})

-- terraform
lsp.configure('terraform-ls', {
  filetypes = {'tf'}
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr}
  local bind = vim.keymap.set

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
end)
lsp.nvim_workspace()
lsp.setup()
