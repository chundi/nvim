return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "kosayoda/nvim-lightbulb" },
  { "ray-x/lsp_signature.nvim" },
  { "stevearc/aerial.nvim" },
  { "mfussenegger/nvim-jdtls" },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "onsails/lspkind-nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "tree-sitter/tree-sitter-rust" },
  { "tree-sitter/tree-sitter-java" },
  { "tree-sitter/tree-sitter-go" },
  { "tree-sitter/tree-sitter-python" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "terrortylor/nvim-comment" },
  { "lervag/vimtex" },
  { "rmagatti/alternate-toggler" },
  { "windwp/nvim-autopairs" },
  { "mg979/vim-visual-multi" },
  { "gcmt/wildfire.vim" },
  { "tpope/vim-surround" },
  { "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        paper = false,
        width_ratio = 0.8,
        height_ratio = 0.8,
      })
      -- 迁移 GlowMarkdown 函数和 markdown 文件类型自动命令
      function GlowMarkdown()
        local file = vim.fn.expand('%:p')
        if not file:match('%.md$') then
          vim.notify("Glow preview only works for markdown (.md) files.", vim.log.levels.WARN)
          return
        end
        local buf = vim.api.nvim_create_buf(false, true)
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)
        local win = vim.api.nvim_open_win(buf, true, {
          relative = 'editor',
          row = row,
          col = col,
          width = width,
          height = height,
          style = 'minimal',
          border = 'rounded',
        })
        vim.api.nvim_buf_call(buf, function()
          vim.fn.termopen({ 'glow', file })
        end)
        vim.bo[buf].modifiable = false
        vim.bo[buf].readonly = true
        vim.bo[buf].buftype = "terminal"
        vim.bo[buf].filetype = "glowpreview"
        vim.keymap.set('n', 'q', function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, { buffer = buf, silent = true })
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_win_set_cursor(win, {1, 0})
          end
        end, 100)
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "ms", ':vsplit | terminal glow %<CR>', { noremap = true, silent = true, buffer = true, desc = "Preview Markdown with Glow" })
          vim.api.nvim_set_keymap('n', 'mp', ':lua GlowMarkdown()<CR>', { noremap = true, silent = true })
        end,
      })
    end
  },
  { "norcalli/nvim-colorizer.lua" },
}