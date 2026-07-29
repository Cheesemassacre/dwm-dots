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
vim.cmd("colorscheme retrobox")
vim.loader.enable()

-- Neovide support
if vim.g.neovide then
  vim.o.guifont = "MesloLGM Nerd Font Mono:h8"
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_padding_top = 15
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5
end

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

  -- {
  --   "rebelot/kanagawa.nvim",
  --   config = function()
  --     vim.cmd("colorscheme retrobox")
  --     --   require('kanagawa').setup({
  --     --     theme = "lotus",
  --     --     commentStyle = { italic = false },
  --     -- })
  --   end,
  -- },

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
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
  },

  {
  "gbprod/cutlass.nvim",
    opts = {
    }
  },

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
          { desc = '  Find File', group = 'Label', action = 'lua require("fzf-lua").files()', key = 'f' },
        },
      },
    })
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  {
  url = "https://codeberg.org/andyg/leap.nvim",
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
   "nvim-tree/nvim-tree.lua",
     lazy = true,
  },

  {
   'saghen/blink.cmp',
   -- optional: provides snippets for the snippet source
   dependencies = { 'rafamadriz/friendly-snippets' },

   -- use a release tag to download pre-built binaries
   version = '1.*',
   -- AND/OR build from source
   -- build = 'cargo build --release',
   -- If you use nix, you can build from source with:
   -- build = 'nix run .#build-plugin',

   ---@module 'blink.cmp'
   ---@type blink.cmp.Config
   opts = {
     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
     -- 'super-tab' for mappings similar to vscode (tab to accept)
     -- 'enter' for enter to accept
     -- 'none' for no mappings
     --
     -- All presets have the following mappings:
     -- C-space: Open menu or open docs if already open
     -- C-n/C-p or Up/Down: Select next/previous item
     -- C-e: Hide menu
     -- C-k: Toggle signature help (if signature.enabled = true)
     --
     -- See :h blink-cmp-config-keymap for defining your own keymap
     keymap = { preset = 'default' },

     appearance = {
       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
       -- Adjusts spacing to ensure icons are aligned
       nerd_font_variant = 'mono'
     },

     -- (Default) Only show the documentation popup when manually triggered
     completion = { documentation = { auto_show = false } },

     -- Default list of enabled providers defined so that you can extend it
     -- elsewhere in your config, without redefining it, due to `opts_extend`
     sources = {
       default = { 'lsp', 'path', 'snippets', 'buffer' },
     },

     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
     --
     -- See the fuzzy documentation for more information
     fuzzy = { implementation = "prefer_rust_with_warning" }
   },
   opts_extend = { "sources.default" }
}

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
vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#83a598' })
vim.api.nvim_set_hl(0, 'Label', { fg = '#458588' })

-- Leap setup
vim.keymap.set({'n', 'x', 'o'}, 'f',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'F',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')

require('leap').opts.preview = function (ch0, ch1, ch2)
  return not (
    ch1:match('%s')
    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
  )
end

-- Lulaline colors
require('lualine').setup {
  options = {
    theme = {
      normal = {
        a = { bg = '', fg = '#ebdbb2' }, 
        b = { bg = '' },
        c = { bg = '' },
      },
      insert = {
        a = { bg = '', bg = '#98971a', fg = '#000000' },
        b = { bg = '' },
        c = { bg = '' },
      },
      visual = {
        a = { bg = '', bg = '#b16286', fg = '#000000' },
        b = { bg = '' },
        c = { bg = '' },
      },
      replace = {
        a = { bg = '' },
        b = { bg = '' },
        c = { bg = '' },
      },
      command = {
        a = { bg = '', bg = '#458588', fg = '#000000' },
        b = { bg = '' },
        c = { bg = '' },
      },
      inactive = {
        a = { bg = '' },
        b = { bg = '' },
        c = { bg = '' },
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

vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- Fzf setup
require'fzf-lua'.setup {
  files = {
    cmd = "rg --files --hidden --glob '!node_modules/*' --glob '!.git/*' --glob '!dist/*' --glob '!.dotfiles/void-packages/*'"
  }
}
