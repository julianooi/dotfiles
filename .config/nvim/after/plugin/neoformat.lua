vim.g.neoformat_try_node_exe = 1
vim.g.neoformat_basic_format_trim = 1
vim.g.neoformat_enabled_sql = {'pg_format'}
vim.g.neoformat_enabled_go = {'gofumpt'}

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Run Neoformat',
  command = 'Neoformat'
})
