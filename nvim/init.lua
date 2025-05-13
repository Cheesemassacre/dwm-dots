vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
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
vim.opt.ruler = false
vim.loader.enable()

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

  -- {
  --   "vim-airline/vim-airline",
  --   dependencies = { "vim-airline/vim-airline-themes" },
  --   config = function()
  --     vim.g.airline_theme = "transparent"
  --     vim.g.airline_powerline_fonts = 0
  --     vim.g["airline#extensions#whitespace#enabled"] = 0
  --   end,
  -- },
  
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
    lazy = true,
  -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
  },

  {
    'numToStr/Comment.nvim',
    lazy = true,
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
  'ggandor/leap.nvim',
  },
  
  {
  'tpope/vim-repeat',
    lazy = true,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  {
  "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
  lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  dependencies = {
    -- main one
    { "ms-jpq/coq_nvim", branch = "coq" },

    -- 9000+ Snippets
    { "ms-jpq/coq.artifacts", branch = "artifacts" },

    -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    -- Need to **configure separately**
    { 'ms-jpq/coq.thirdparty', branch = "3p" }
    -- - shell repl
    -- - nvim lua api
    -- - scientific calculator
    -- - comment banner
    -- - etc
  },
  init = function()
    vim.g.coq_settings = {
        auto_start = true, -- if you want to start COQ at startup
        auto_start ='shut-up',
        -- Your COQ settings here
    }
  end,
  config = function()
    -- Your LSP settings here
  end,
 },
  
 {
  "nvim-tree/nvim-tree.lua",
    lazy = true,
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

require('lualine').setup {
  options = {
    theme = {
      normal = {
        a = { bg = 'NONE', fg = '#dcd7ba' }, 
        b = { bg = 'NONE' },
        c = { bg = 'NONE' },
      },
      insert = {
        a = { bg = 'NONE', bg = '#98bb6c', fg = '#000000' },
        b = { bg = 'NONE' },
        c = { bg = 'NONE' },
      },
      visual = {
        a = { bg = 'NONE', bg = '#938aa9', fg = '#000000' },
        b = { bg = 'NONE' },
        c = { bg = 'NONE' },
      },
      replace = {
        a = { bg = 'NONE' },
        b = { bg = 'NONE' },
        c = { bg = 'NONE' },
      },
      command = {
        a = { bg = 'NONE', bg = '#7fb4ca', fg = '#000000' },
        b = { bg = 'NONE' },
        c = { bg = 'NONE' },
      },
      inactive = {
        a = { bg = 'NONE' },
        b = { bg = 'NONE' },
        c = { bg = 'NONE' },
      },
    },
    component_separators = { left = '', right = '' }, 
    section_separators = { left = '', right = '' },  
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

-- NvimTree 
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

-- NvimTree keybind
vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
