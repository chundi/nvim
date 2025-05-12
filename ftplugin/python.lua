local lspconfig = require("lspconfig")

-- 启用 Python LSP
lspconfig.pyright.setup({})

-- 设置缩进等编辑器行为
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

lspconfig.pyright.setup {
  on_attach = function(client, bufnr)
    -- 按需添加键位绑定，比如跳转、hover 等
    local opts = { noremap=true, silent=true, buffer=bufnr }
    -- 跳转到定义
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- 显示提示信息
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- 重命名
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    -- 代码操作
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  end,
}

