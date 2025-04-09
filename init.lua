require('env')
require('options')
require('plugins')
require('colorscheme')
require('func')
require('nvim-tree').setup({
  sort_by = "case_sensitive",
  hijack_cursor = true,
  open_on_tab = true,
  view = {
    width = 30,
    side = 'left',
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
      glyphs = {
        bookmark = " ",
        folder = {
          arrow_closed = "⏵",
          arrow_open = "⏷",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "⌥",
          renamed = "➜",
          untracked = "★",
          deleted = "⊖",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    custom = {
      ".git/"
    },
    exclude = {
      ".gitignore"
    },
    dotfiles = false
  }
})

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- treesitter 配置
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "rust", "java" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  folding = {
    enable = true
  },
})

-- dashboard 配置
require('dashboard-conf')

-- 透明配置
require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  },
  extra_groups = {
    'NvimTreeNormal', 'StatusLine', 'StatusLineNC', 'TabLine', 'TabineFill', 'TabLineSel', 'VertSplit',
  }, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})
vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })

-- 设置 lualine 透明
-- require('transparent').clear_prefix('lualine')

-- lualine 配置
require('lualine').setup({
  options = {
    theme = 'auto'
  }
})

vim.opt.termguicolors = true

local bufferline = require('bufferline')
bufferline.setup {
  options = {
    mode = "tabs",
    separator_style = "slant",
  }
}


-- 主题 tokyonight 配置，此处只配置了背景是否透明
require('tokyonight').setup { transparent = vim.g.transparent_enabled }
-- 主题 synthwave84 配置
require('synthwave84').setup {
  glow = {
    error_msg = true,
    type2 = true,
    func = true,
    keyword = true,
    operator = false,
    buffer_current_target = true,
    buffer_visible_target = true,
    buffer_inactive_target = true,
  }
}
-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}

-- neovide 配置
if vim.g.neovide then
  require('neovide')
end

require('lsp-setup')
require('symbols-outline').setup()

vim.api.nvim_set_keymap('n', '<F8>', ':SymbolsOutline<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

