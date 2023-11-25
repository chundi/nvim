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
require('dashboard-conf')
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
-- require('transparent').clear_prefix('lualine')
require('lualine').setup({
  options = {
    theme = 'tokyonight'
  }
})
vim.opt.termguicolors = true
require('bufferline').setup{}
vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
require('tokyonight').setup { transparent = vim.g.transparent_enabled }
if vim.g.neovide then
  vim.o.guifont = "Maple Mono SC NF:h12"
  vim.g.neovide_theme = "tokyonight"

  -- vim.g.neovide_remember_window_size = true

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5

  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end

  -- vim.g.neovide_transparency = 0.8
  -- vim.g.transparency = 0.2
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()
  -- vim.g.neovide_background_color = "#1f2335"

  vim.g.neovide_floating_blur_amount_x = 15.0
  vim.g.neovide_floating_blur_amount_y = 15.0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_cursor_vfx_mode = "pixiedust"

  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 10.0

end
