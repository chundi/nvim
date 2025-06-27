return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "java", "go", "rust" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        fold = {
          enable = true,
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        -- 添加其他文件类型的格式化程序
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "flake8" },
        -- 添加其他文件类型的 linter
      }
      vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter", "InsertLeave"}, {
        group = vim.api.nvim_create_augroup("nvim-lint", {clear = true}),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}