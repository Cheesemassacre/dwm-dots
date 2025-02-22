vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.title = true
vim.opt.titlestring = "%f - NVIM"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.showmode = false
vim.env.FZF_DEFAULT_COMMAND = "find . \\! \\( -type d -path ./.git -prune \\) \\! -type d \\! -name '*.tags' -printf '%P\\n'"
vim.g.have_nerd_font = true
vim.opt.scrolloff = 10

-- Lazy.nvim install
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

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy packages
require("lazy").setup({

  {
    "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
  },

  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa")
      --   require('kanagawa').setup({
      --     theme = "lotus",
      --     commentStyle = { italic = false },
      -- })
    end,
  },

  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat",
          "NvimTreeNormal",
        },
      })
    end,
  },

  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_theme = "transparent"
      vim.g.airline_powerline_fonts = 0
      vim.g["airline#extensions#whitespace#enabled"] = 0
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
      })
    end,
  },

  {
  "gbprod/cutlass.nvim",
    opts = {
    }
  },

--  {
--     "Exafunction/codeium.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "hrsh7th/nvim-cmp",
--     },
--     config = function()
--         require("codeium").setup({
--         })
--     end,
-- },

  {
    "nvim-treesitter/nvim-treesitter", 
      build = ":TSUpdate",
      config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end,
  },

  {
  "ibhagwan/fzf-lua",
  -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
  },

  {
    'numToStr/Comment.nvim',
      opts = {
        -- add any options here
    }
  },

  {
  'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
    require('dashboard').setup ({
      -- config
      theme = 'hyper', 
      config = {
        week_header = {
        enable = false,
        },
          header = {
            '', 
            ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            '',
            '',
          },
        shortcut = {
          { desc = '  New File', group = 'Label', action = 'enew', key = 'n' },
          { desc = '  FZF Files', group = 'Label', action = 'lua require("fzf-lua").files()', key = 'f' },
        },
      },
    })
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  {
  'ggandor/leap.nvim'
  },
  
  {
  'tpope/vim-repeat'
  },

})

-- FZF keybinds
vim.keymap.set("n", "<leader>sf", function()
  require("fzf-lua").files()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader><leader>", function()
  require("fzf-lua").buffers()
end, { noremap = true, silent = true })

require("fzf-lua").setup{
    file_icon_padding = '',
}

-- Dashboard colors
vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#957fb8' })
vim.api.nvim_set_hl(0, 'Label', { fg = '#7e9cd8' })

-- Leap.nvim keymap
vim.keymap.set({'n', 'x', 'o'}, 'f',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'F',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
