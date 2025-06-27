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
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", function()
          local diagnostics = vim.diagnostic.get(0)
          local has_diagnostics_at_cursor = false
          for _, diag in ipairs(diagnostics) do
            if diag.lnum == vim.fn.line('.') - 1 then
              has_diagnostics_at_cursor = true
              break
            end
          end

          if has_diagnostics_at_cursor then
            vim.diagnostic.open_float()
          else
            vim.lsp.buf.hover()
          end
        end, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "rust_analyzer", "lua_ls" },
        handlers = {
          function (server_name)
            require("lspconfig")[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,
          ["jdtls"] = function () end,
        }
      })
    end
  },
  { "kosayoda/nvim-lightbulb" },
  { "ray-x/lsp_signature.nvim" },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", function()
          local diagnostics = vim.diagnostic.get(0)
          local has_diagnostics_at_cursor = false
          for _, diag in ipairs(diagnostics) do
            if diag.lnum == vim.fn.line('.') - 1 then
              has_diagnostics_at_cursor = true
              break
            end
          end

          if has_diagnostics_at_cursor then
            vim.diagnostic.open_float()
          else
            vim.lsp.buf.hover()
          end
        end, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)
        -- JDTLS specific keymaps
        vim.keymap.set('n', '<leader>oi', "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
        vim.keymap.set('n', '<leader>ev', "<cmd>lua require'jdtls'.extract_variable()<CR>", opts)
        vim.keymap.set('v', '<leader>ev', "<esc><cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
        vim.keymap.set('n', '<leader>ec', "<cmd>lua require'jdtls'.extract_constant()<CR>", opts)
        vim.keymap.set('v', '<leader>ec', "<esc><cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
        vim.keymap.set('v', '<leader>em', "<esc><cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'})
      if not root_dir then return end
      
      local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
      local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name
      
      local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
      local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      
      local os_config_name = vim.loop.os_uname().sysname == 'Darwin' and 'mac' or 'linux'
      local platform_config = jdtls_path .. "/config_" .. os_config_name
      
      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xms1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', launcher_jar,
          '-configuration', platform_config,
          '-data', workspace_dir,
        },
        root_dir = root_dir,
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
        },
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*"
              },
              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*", 
                "sun.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
              },
              hashCodeEquals = {
                useJava7Objects = true,
              },
            },
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-" .. vim.env.JAVA_VERSION,
                  path = vim.env.JAVA_HOME,
                },
              }
            },
            inlayHints = { parameterNames = { enabled = true } },
            import = {
              maven = { enabled = true },
              gradle = { enabled = true },
            },
          }
        },
      }
      
      require('jdtls').start_or_attach(config)
    end,
  },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "onsails/lspkind-nvim" },
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
}
