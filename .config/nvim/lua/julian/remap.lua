vim.keymap.set("n", "\\", "<cmd>w<cr>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>gy", "<cmd>let @+=expand('%:p')<CR>")

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader>hl", "<cmd>set hlsearch!<CR>")

vim.keymap.set("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<CR>")
vim.keymap.set("n", "<C-Space>", "<cmd>NvimTmuxNavigateNext<CR>")

vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")

-- vim-go
vim.keymap.set("n", "<leader>gf", "<cmd>GoFillStruct<cr>")

-- rest-nvim
vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<CR>", { desc = "Run request under cursor" })
vim.keymap.set("n", "<leader>rp", "<cmd>RestNvimLast", { desc = "Run previous request under cursor" })
vim.keymap.set("n", "<leader>rc", "<cmd>RestNvimPreview", { desc = "View cURL command" })

-- lsp
vim.keymap.set("n", "<leader><leader>r", "<cmd>LspRestart<CR>", { desc = "restart lsp" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "show diagnostics" })

vim.keymap.set("n", "<leader>pc", function()
	local filepath = vim.fn.expand("%:p")
	vim.fn.setreg("+", filepath) -- write to clippoard
end)
