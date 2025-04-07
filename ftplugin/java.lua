-- 查找项目根目录
local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'})
if root_dir == "" then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.expand('~/Projects/opensource/') .. project_name

-- 使用 Mason 安装的 jdtls
local mason_registry = require('mason-registry')
local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local platform_config = jdtls_path .. "/config_mac" -- 根据你的系统修改: config_linux, config_mac, config_win

-- 配置 Java 语言服务器
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
  
  -- 这里使用与前面相同的 on_attach 函数
  on_attach = function(client, bufnr)
    -- 基本键位映射
    -- n、v、i、x、c、t 分别表示 普通模式、可视模式、插入模式、可视块模式、命令行模式、终端模式
    -- 还有其它模式，参考帮助文档
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- 跳转到声明
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    -- 跳转到定义
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- 跳转到实现
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- 查看引用
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- 显示文档/悬停信息
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- 显示签名帮助
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- 重命名符号
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    -- 显示代码操作
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    -- 格式化代码
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Java 特定功能
    -- 用法：在确定的模式下，先按下<leader>键（默认是'\'），再按后边的oi等命令
    -- 组织导入
    vim.keymap.set('n', '<leader>oi', "<Cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
    -- 提取变量（普通模式下）
    vim.keymap.set('n', '<leader>ev', "<Cmd>lua require'jdtls'.extract_variable()<CR>", bufopts)
    -- 提取变量（可视模式下）
    vim.keymap.set('v', '<leader>ev', "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", bufopts)
    -- 提取常量（普通模式下）
    vim.keymap.set('n', '<leader>ec', "<Cmd>lua require'jdtls'.extract_constant()<CR>", bufopts)
    -- 提取常量（可视模式下）
    vim.keymap.set('v', '<leader>ec', "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", bufopts)
    -- 提取方法（可视模式下）
    vim.keymap.set('v', '<leader>em', "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", bufopts)
  end,
  
  -- 支持自动完成
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  
  -- 项目设置
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
        -- 微调项目设置，可根据需要添加
        runtimes = {
          {
            name = "JavaSE-21", -- 根据你的项目需求调整
            path = vim.fn.expand("$JAVA_HOME"),
          },
        }
      },
      -- 预加载工作区
      inlayHints = { parameterNames = { enabled = true } },
      autobuild = { enabled = true },
      import = {
        maven = { enabled = true },
        gradle = { enabled = true },
      },
      project = {
        referencedLibraries = {
          include = jdtls_path .. "/lombok.jar", -- 如果需要
        },
      },
      workspace = {
        preloadSources = true,  -- 预加载工作区源码
        maxConcurrentBuilds = 4, -- 最大同时构建数
      }
    }
  },
  
  -- 如果你有可用插件，可以在这里添加
  init_options = {
    bundles = {}
  },
}

-- 启动 JDTLS
require('jdtls').start_or_attach(config)
