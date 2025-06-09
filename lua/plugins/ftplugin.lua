return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local none_ls = require("null-ls")
      none_ls.setup({
        sources = {
          none_ls.builtins.formatting.black,
          none_ls.builtins.diagnostics.flake8,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = "python",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
          local opts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      -- 这里直接粘贴 java.lua 的内容
      local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', '.github', '.idea', '.vscode'})
      if root_dir == "" then return end
      local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
      local workspace_dir = vim.fn.expand('~/Projects/lsp_data/') .. project_name
      local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
      local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      local uname = vim.loop.os_uname().sysname
      local jdtls_platform
      if uname == "Darwin" then
        jdtls_platform = "mac"
      elseif uname == "Linux" then
        jdtls_platform = "linux"
      else
        jdtls_platform = "win"
      end
      local platform_config = jdtls_path .. "/config_" .. jdtls_platform
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
        on_attach = function(client, bufnr)
          local bufopts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set('n', 'gD', ':Telescope lsp_type_definitions<CR>')
          vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
          vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
          vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
          vim.keymap.set('n', '<leader>oi', "<Cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
          vim.keymap.set('n', '<leader>ev', "<Cmd>lua require'jdtls'.extract_variable()<CR>", bufopts)
          vim.keymap.set('v', '<leader>ev', "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", bufopts)
          vim.keymap.set('n', '<leader>ec', "<Cmd>lua require'jdtls'.extract_constant()<CR>", bufopts)
          vim.keymap.set('v', '<leader>ec', "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", bufopts)
          vim.keymap.set('v', '<leader>em', "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", bufopts)
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
                  name = "JavaSE-21",
                  path = vim.env.JAVA_HOME,
                },
              }
            },
            inlayHints = { parameterNames = { enabled = true } },
            autobuild = { enabled = true },
            import = {
              maven = { enabled = true },
              gradle = { enabled = true },
            },
            project = {
              referencedLibraries = {
                include = jdtls_path .. "/lombok.jar",
              },
            },
            workspace = {
              preloadSources = true,
              maxConcurrentBuilds = 4,
            }
          }
        },
        init_options = {
          bundles = {}
        },
      }
      require('jdtls').start_or_attach(config)
    end,
  },
} 
