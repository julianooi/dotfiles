require("julian")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- colorschemes
	{ "rose-pine/neovim", name = "rose-pine" },
	"Mofiqul/dracula.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	"chriskempson/base16-vim",

	-- debugger
	{
		"mfussenegger/nvim-dap",
		name = "dap",
		config = false,
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dapui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"folke/neodev.nvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dapui = require("dapui")
			dapui.setup()
			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		name = "nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"leoluz/nvim-dap-go",
		name = "dap-go",
		config = function()
			require("dap-go").setup({})
			vim.keymap.set("n", "<leader>dt", function()
				require("dap-go").debug_test()
			end, { desc = "debug go test method" })
		end,
	},

	-- lsp / treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"vrischmann/tree-sitter-templ",
		},
	},
	{
		"nvim-treesitter/playground",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- { 'fatih/vim-go', build = 'GoUpdateBinaries' },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "dev-v3",
		config = false,
		dependencies = {
			{ "folke/neodev.nvim" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "kristijanhusak/vim-dadbod-completion" },
		},
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
		config = function()
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip").setup()
		end,
	},
	"sago35/tinygo.vim",
	"folke/neodev.nvim",
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "nvim-lua/plenary.nvim", "luarocks.nvim" },
		name = "rest-nvim",
		config = function()
			require("rest-nvim").setup()
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = false,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = { enabled = false },
			})
		end,
	},

	-- tools
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- {
	-- 	"chentoast/marks.nvim",
	-- 	config = function()
	-- 		require("marks").setup({
	-- 			default_mappings = true,
	-- 		})
	-- 	end,
	-- },
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"airblade/vim-gitgutter",
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	tag = "nightly",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	lazy = false,
	-- 	config = function()
	-- 		local t = require("nvim-tree")
	-- 		t.setup()
	-- 		require("nvim-tree.git").ignore = false
	-- 	end,
	-- },
	"alexghergh/nvim-tmux-navigation",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"sbdchd/neoformat",
	"ggandor/leap.nvim",
	{
		"BartSte/nvim-project-marks",
		lazy = false,
		config = function()
			require("projectmarks").setup({})
		end,
	},
	"kdheepak/lazygit.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { scope = { show_start = false, show_end = false } },
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"cbochs/portal.nvim",
		-- Optional dependencies
		dependencies = {
			"cbochs/grapple.nvim",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- session management
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = {
					"~/",
					"~/Projects",
					"~/Downloads",
					"/",
				},
			})
		end,
	},

	-- status line
	"vim-airline/vim-airline",
	"vim-airline/vim-airline-themes",

	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({})
		end,
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
		},
	},

	-- {
	-- 	"github/copilot.vim",
	-- },
})
