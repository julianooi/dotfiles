local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})

local builtin = require('telescope.builtin')

local function git_files()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require"telescope.builtin".git_files(opts)
  else
    require"telescope.builtin".find_files(opts)
  end
end

vim.keymap.set('n', 'gL', function() builtin.diagnostics{ bufnr=0 } end, {desc='File diagnostics'})
vim.keymap.set('n', 'gp', function() builtin.diagnostics() end, {desc='Project diagnostics'})
vim.keymap.set('n', '<leader>pf', function() builtin.find_files{hidden=true, no_ignore=true, no_ignore_parent=true} end, {desc='find files'})
vim.keymap.set('n', '<leader>pg', git_files, {desc='find in git files'})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {desc='telescope buffers'})
vim.keymap.set('n', '<leader>ps', function()
  vim.ui.input({
    prompt = 'Grep > ',
    -- default = vim.fn.expand('<cword>'),
  }, function (input)
    if input == nil then return end
    builtin.grep_string({ search = input })
  end)
end, {desc='find files with text in project'})
