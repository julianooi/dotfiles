-- vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
--   desc = 'Run go lint on insert leave',
--   pattern = { 'go' },
--   command = 'GoLint!'
-- })
vim.g.go_fmt_command="gopls"
vim.g.go_gopls_gofumpt=1
