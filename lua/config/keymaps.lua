-- 全局快捷键
vim.api.nvim_set_keymap('n', '<F8>', ':SymbolsOutline<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- 定义代码折叠快捷键
-- 折叠代码
vim.api.nvim_set_keymap('n', 'zc', ':foldclose<CR>', { noremap = true, silent = true })
-- 打开折叠
vim.api.nvim_set_keymap('n', 'zo', ':foldopen<CR>', { noremap = true, silent = true })
-- 切换折叠状态
vim.api.nvim_set_keymap('n', 'za', ':fold<CR>', { noremap = true, silent = true })
-- 打开所有折叠
vim.api.nvim_set_keymap('n', 'zR', ':set foldlevel=99<CR>', { noremap = true, silent = true })
-- 收起所有折叠
vim.api.nvim_set_keymap('n', 'zM', ':set foldlevel=0<CR>', { noremap = true, silent = true })
-- 绑定 gn 和 gp 到切换 buffer
vim.api.nvim_set_keymap('n', 'gn', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gt', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gT', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
