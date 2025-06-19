return {
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
      -- 确保只对 Java 文件执行一次初始化
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
          -- 获取当前文件所在的项目根目录
          local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', '.github', '.idea', '.vscode'})
          if not root_dir then return end
          
          -- 检查是否已经为这个项目创建了客户端
          local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
          local workspace_dir = vim.fn.expand('~/Projects/lsp_data/') .. project_name
          
          -- 设置 JDTLS 路径
          local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
          local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
          
          -- 检测操作系统
          local uname = vim.loop.os_uname().sysname
          local jdtls_platform = 'linux' -- 默认为 linux
          if uname == 'Darwin' then
            jdtls_platform = 'mac'
          elseif uname == 'Windows' or uname == 'Windows_NT' then
            jdtls_platform = 'win'
          end
          
          local platform_config = jdtls_path .. "/config_" .. jdtls_platform
          
          -- 设置 LSP 配置
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
              -- 设置缓冲区本地键位映射
              local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
              local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
              
              -- 启用补全功能
              buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
              
              -- 设置键位映射
              local opts = { noremap=true, silent=true }
              buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
              buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
              buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
              buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
              buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
              buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
              buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
              buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
              buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
              
              -- JDTLS 特定命令
              buf_set_keymap('n', '<leader>oi', "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
              buf_set_keymap('n', '<leader>ev', "<cmd>lua require'jdtls'.extract_variable()<CR>", opts)
              buf_set_keymap('v', '<leader>ev', "<esc><cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
              buf_set_keymap('n', '<leader>ec', "<cmd>lua require'jdtls'.extract_constant()<CR>", opts)
              buf_set_keymap('v', '<leader>ec', "<esc><cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
              buf_set_keymap('v', '<leader>em', "<esc><cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
              
              -- 设置高亮
              if client.supports_method('textDocument/documentHighlight') then
                vim.api.nvim_exec([[
                  augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                  augroup END
                ]], false)
              end
              
              -- 设置格式化选项
              client.server_capabilities.documentFormattingProvider = true
              client.server_capabilities.documentRangeFormattingProvider = true
            end,
            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            flags = {
              debounce_text_changes = 150,
            },
            init_options = {
              extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
            },
          }
          
          -- 添加 settings 到 config
          config.settings = {
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
          
          -- 启动 JDTLS
          require('jdtls').start_or_attach(config)
        end,
      })
    end,
  },
}
