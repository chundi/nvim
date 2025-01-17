-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Codeium
  -- use 'Exafunction/codeium.vim'

  -- Colorschemes
  use 'rebelot/kanagawa.nvim'
  use 'titanzero/zephyrium'
  use 'rafamadriz/neon'
  use 'Mofiqul/dracula.nvim'
  use 'morhetz/gruvbox'
  use 'fneu/breezy'
  use "folke/tokyonight.nvim"
  use "lunarvim/synthwave84.nvim"
  use "projekt0n/github-nvim-theme"

  -- Terminal
  -- Alt+= to open Terminal
  -- Alt+Shift+k/j to switch window
  -- Alt+q to Normal mode
  use 'skywind3000/vim-terminal-help'

  -- Transparent background
  -- Usage: :TransparentEnable
  use 'xiyaowong/transparent.nvim'

  -- Language Server Protocol Configuration
  use 'neovim/nvim-lspconfig'
  -- Language Server Protocol Manager
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- Tip tools
  use 'kosayoda/nvim-lightbulb'
  use 'ray-x/lsp_signature.nvim'
  -- Devicons
  use 'nvim-tree/nvim-web-devicons'
  -- File tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  -- Alternate toggler <leader>ta
  use 'rmagatti/alternate-toggler'
  -- Brackets auto pair
  use 'windwp/nvim-autopairs'
  -- Multi-editing <c-n>
  use 'mg979/vim-visual-multi'
  -- Object selecting press <cr>
  use 'gcmt/wildfire.vim'
  -- Fast brackets adding
  use 'tpope/vim-surround'
  -- Status line
  use {
      'nvim-lualine/lualine.nvim',
      requires = {
          'nvim-tree/nvim-web-devicons',
          opt = true
      }
  }

  -- dashboard
  use 'nvimdev/dashboard-nvim'

  -- Buffer line
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Complete
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lua'
  -- Snippet
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Complete icons
  use 'onsails/lspkind-nvim'
  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'tree-sitter/tree-sitter-rust'
  use 'tree-sitter/tree-sitter-java'
  use 'tree-sitter/tree-sitter-go'
  use 'tree-sitter/tree-sitter-python'
  use 'HiPhish/rainbow-delimiters.nvim'

  -- Comment toggler
  use 'terrortylor/nvim-comment'
  -- LaTeX Support
  use 'lervag/vimtex'
  -- Code outline
  use 'stevearc/aerial.nvim'
  -- Color Preview
  use 'norcalli/nvim-colorizer.lua'

end)
