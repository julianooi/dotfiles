require("oil").setup()

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<Esc>", function()
	local bufn = vim.fn.expand("%")
	if bufn.find(bufn, "^oil://") then
		require("oil").close()
	end
end)
