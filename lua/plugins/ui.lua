return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
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
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup {
        options = {
          mode = "tabs",
          separator_style = "thick",
        }
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "auto"
        }
      }
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        shortcut_type = 'number',
        preview = {
          command,
          file_path
        },
        config = {
          week_header = {
            enable = true
          },
          packages = {
            enable = true
          },
          shortcut = {
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' New File',
              group = 'Label',
              action = 'bd',
              key = 'i',
            },
          }
        }
      }
    end,
  },
  { "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLineNr', 'EndOfBuffer',
        },
        extra_groups = {
          'NvimTreeNormal', 'StatusLine', 'StatusLineNC', 'TabLine', 'TabLineFill',
          'TabLineSel', 'VertSplit',
        },
        exclude_groups = {},
      })
      vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
    end,
  },
  { "nvim-tree/nvim-web-devicons" },
  { "stevearc/aerial.nvim" },
  { "norcalli/nvim-colorizer.lua" },
  { "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  { "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
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
    end,
  },
} 