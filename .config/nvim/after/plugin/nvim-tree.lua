vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
  view = {
    mappings = {
      list = {
        { key = "<C-k>", action = "" },
        { key = "<C-f>", action = "toggle_file_info" },
      }
    }
  }
})

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

local function load_nvim_tree_session(ev)
  require('nvim-tree.api').tree.reload()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.api.nvim_create_autocmd({ 'SessionLoadPost' }, { callback = load_nvim_tree_session })

