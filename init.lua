require('options')
require('plugins')
require('colorscheme')
require('dashboard-conf')
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
        file = false,
        folder = false,
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
require('nvim-treesitter.configs').setup({
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    -- disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    }
  }
})

