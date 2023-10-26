vim.g.neoformat_try_node_exe = 1
vim.g.neoformat_basic_format_trim = 1
vim.g.neoformat_enabled_sql = { "" }
vim.g.neoformat_enabled_go = { "" }
vim.g.neoformat_enabled_html = { "prettierd", "prettier" }
vim.g.neoformat_enabled_yaml = { "prettierd" }
vim.g.neoformat_enabled_gohtml = { "prettierd", "prettier" }

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	desc = "Run Neoformat",
	command = "Neoformat",
})
