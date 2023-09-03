-- 说明：
-- vim.g.{name}: 全局变量
-- vim.b.{name}: 缓冲区变量
-- vim.w.{name}: 窗口变量
-- vim.bo.{option}: buffer-local 选项
-- vim.wo.{option}: window-local 选项
-- 也可以都放到 vim.opt 下

-- Codeium
vim.g.codeium_enabled = true
-- 自动补全不自动选中
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- 补全增强
vim.opt.wildmenu = true
-- 补全最多显示多少行
vim.o.pumheight = 10
-- 支持全鼠标操作
vim.opt.mouse = 'a'

-- 4 空格缩进
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- 使用空格代替 tab
vim.opt.expandtab = true
-- 新行自动对齐
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 显示行号
vim.opt.number = true
-- 显示相对行号
-- vim.opt.relativenumber = true
-- 高亮光标所在行
vim.opt.cursorline = true
-- split 时在下方显示新文件
vim.opt.splitbelow = true
-- vsplit 时在右方显示新文件
vim.opt.splitright = true

-- 搜索时忽略大小写
vim.opt.ignorecase = true
-- 搜索时如果输入包含大写字母，则不忽略大小写
vim.opt.smartcase = true
-- 搜索不要高亮
-- vim.o.hlsearch = false
-- 边输入边搜索
-- vim.o.incsearch = true

-- 指定编码
vim.opt.fileencoding = 'utf-8'
vim.g.encoding = 'UTF-8'

-- 移动光标时下方/右侧保留多少行
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- 显示左侧图标指示列
vim.wo.signcolumn = 'yes'

-- 显示文本过长参考线
vim.wo.colorcolumn = '120'

-- 向左/右缩进移动时移动长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

-- 当文件被外部程序修改时，自动加载
vim.opt.autoread = true

-- 禁止折行
vim.wo.wrap = false

-- 颜色显示
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.termguicolors = true

-- 显示不可见字符，这里把空格显示为一个点
vim.opt.list = true
vim.opt.listchars = "space:·"

-- 是否显示当前模式是 --INSERT-- 还是 --NORMAL-- 等
vim.opt.showmode = false

