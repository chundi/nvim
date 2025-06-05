require('config.env')
require('config.options')
require('config.neovide')
require('config.colorscheme')
require('config.func')

-- 加载 LazyVim 插件管理和插件
require('lazyvim')

-- 全局快捷键
vim.api.nvim_set_keymap('n', '<F8>', ':SymbolsOutline<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })


