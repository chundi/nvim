return {
  { "rebelot/kanagawa.nvim" },
  { "titanzero/zephyrium" },
  { "rafamadriz/neon" },
  { "Mofiqul/dracula.nvim" },
  { "morhetz/gruvbox" },
  { "fneu/breezy" },
  { "folke/tokyonight.nvim",
    opts = {
      transparent = vim.g.transparent_enabled,
    },
  },
  { "lunarvim/synthwave84.nvim",
    opts = {
      glow = {
        error_msg = true,
        type2 = true,
        func = true,
        keyword = true,
        operator = false,
        buffer_current_target = true,
        buffer_visible_target = true,
        buffer_inactive_target = true,
      },
    },
  },
  { "projekt0n/github-nvim-theme" },
  { "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'deep'
      }
      require('onedark').load()
    end
  },
} 
