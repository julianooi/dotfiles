require("julian")

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- colorschemes
  { 'rose-pine/neovim', name = 'rose-pine' },
  'Mofiqul/dracula.nvim',
  { "catppuccin/nvim", name = "catppuccin" },
  'chriskempson/base16-vim',

  -- debugger
  {
    'mfussenegger/nvim-dap',
    name='dap',
    config=false,
  },
  {
    'rcarriga/nvim-dap-ui',
    name = 'dapui',
    dependencies = {"mfussenegger/nvim-dap", 'folke/neodev.nvim'},
    config = function ()
      local dapui = require('dapui')
      dapui.setup()
      local dap = require('dap')
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    name = 'nvim-dap-virtual-text',
    config = function ()
      require('nvim-dap-virtual-text').setup()
    end,
  },
  {
    'leoluz/nvim-dap-go',
    name = 'dap-go',
    config = function ()
      require('dap-go').setup({
      })
      vim.keymap.set('n', '<leader>dt', function () require('dap-go').debug_test() end, {desc='debug go test method'})
    end
  },

  -- lsp / treesitter
  {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
  {
    'nvim-treesitter/playground',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
  },
  { 'fatih/vim-go', build = 'GoUpdateBinaries' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    config = false,
    dependencies = {
      {'folke/neodev.nvim'},
    },
  },
	{
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'}
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
    },
  },
	{'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
			{'rafamadriz/friendly-snippets'}, -- Optional
    }
  },
  'sago35/tinygo.vim',
  'folke/neodev.nvim',
  {
    'rest-nvim/rest.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    name = 'rest-nvim',
  },
  'nvim-treesitter/nvim-treesitter-context',
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = false,
  },

  -- tools
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {
        default_mappings = true,
      }
    end
  },
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',
  {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    config = function()
      local t = require('nvim-tree')
      t.setup()
      require('nvim-tree.git').ignore = false
    end
  },
  'alexghergh/nvim-tmux-navigation',
  {
    'numToStr/Comment.nvim',
    config = function ()
      require('Comment').setup()
    end,
  },
  'sbdchd/neoformat',
  'ggandor/leap.nvim',
  'kdheepak/lazygit.nvim',
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_end_of_line = true,
      }
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  },
  {
    'rest-nvim/rest.nvim',
    config = function()
      require('rest-nvim').setup({
        skip_ssl_verification = true,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,

      })
    end
  },
  {
    'cbochs/portal.nvim',
    -- Optional dependencies
    dependencies = {
        'cbochs/grapple.nvim',
        'ThePrimeagen/harpoon',
    },
  },

  -- session management
  {
    'rmagatti/auto-session',
    config = function ()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_suppress_dirs = {
          '~/',
          '~/Projects',
          '~/Downloads',
          '/',
        },
        pre_save_cmds = {"tabdo NvimTreeClose"},
        post_restore_cmds = {"tabdo NvimTreeOpen", "tabdo NvimTreeRefresh"},
      }
    end
  },

  -- status line
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',

  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require('which-key').setup {}
    end
  }
})

