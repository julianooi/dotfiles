local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
	},
})

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end)

vim.keymap.set("n", "<leader>,", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>.", function()
	harpoon:list():next()
end)

-- harpoon:setup()

-- vim.keymap.set("n", "<leader>a", function()
-- 	harpoon.list():append()
-- end, { desc = "append to harpoon" })
-- vim.keymap.set("n", "<C-e>", function()
-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
-- end, { desc = "toggle harpoon" })
--
-- vim.keymap.set("n", "<C-9>", function()
-- 	harpoon:list():select(1)
-- end, { desc = "harpoon 1" })
-- vim.keymap.set("n", "<C-0>", function()
-- 	harpoon:list():select(2)
-- end, { desc = "harpoon 2" })
-- vim.keymap.set("n", "<C-->", function()
-- 	harpoon:list():select(3)
-- end, { desc = "harpoon 3" })
-- vim.keymap.set("n", "<C-=>", function()
-- 	harpoon:list():select(4)
-- end, { desc = "harpoon 4" })
--
-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function()
-- 	harpoon:list():prev()
-- end, { desc = "harpoon previous" })
-- vim.keymap.set("n", "<C-S-N>", function()
-- 	harpoon:list():next()
-- end, { desc = "harpoon next" })
