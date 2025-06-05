# Neovim 配置（基于 LazyVim）**本文本由 cursor 通过 gpt-4.1 自动生成**

本仓库为个人 Neovim 配置，已从 Packer 迁移至 [LazyVim](https://github.com/folke/lazy.nvim) 插件管理，支持多语言开发、丰富 UI 与高效工作流。

---

## 目录结构

```
├── init.lua              # Neovim 主入口，加载全局配置和 LazyVim
├── lua/
│   ├── config/           # 全局配置（选项、主题、LSP、Neovide 等）
│   ├── plugins/          # 插件声明与配置（每类/每组插件一个文件）
│   └── lazyvim.lua       # LazyVim 插件加载主入口
└── ...
```

- **config/** 目录：全局选项、主题、LSP、UI、Neovide 等配置，互不干扰，易于维护。
- **plugins/** 目录：所有插件声明与配置，按功能拆分，便于扩展和懒加载。

---

## 安装与使用

1. **依赖**：
   - [Neovim 0.9+](https://github.com/neovim/neovim)
   - [git](https://git-scm.com/)
   - 推荐安装 [ripgrep](https://github.com/BurntSushi/ripgrep) 以提升搜索体验

2. **初始化**：
   - 首次启动 Neovim 时，LazyVim 会自动拉取所有插件，无需手动操作。
   - 推荐执行 `:Mason` 安装 LSP/格式化等二进制依赖。

3. **常用命令**：
   - `:Lazy`         # LazyVim 插件管理界面
   - `:Mason`        # LSP/DAP/格式化等二进制管理
   - `:checkhealth`  # 检查依赖与环境

---

## 插件管理

- **添加插件**：在 `lua/plugins/` 下新建或编辑对应模块，按 LazyVim 格式添加即可。
- **移除插件**：删除或注释对应声明，重启 Neovim 并在 `:Lazy` 中同步。
- **配置插件**：推荐将复杂配置写在 `config = function() ... end` 内，或拆分为独立文件 require。

---

## 迁移与常见问题

- 本配置已完全去除 Packer 相关内容，所有插件声明与配置均已适配 LazyVim。
- 全局配置（如 options、env、neovide 等）均独立存放，便于维护和迁移。
- 如遇插件未生效、LSP 无法启动等问题，优先检查 `:Lazy` 和 `:Mason` 状态。
- 如需自定义主题、快捷键、LSP 等，直接编辑 `config/` 下对应文件。

---

## 致谢

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- [neovim/neovim](https://github.com/neovim/neovim)
- 以及所有优秀的开源插件作者！
