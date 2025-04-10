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

  -- 启动 glow
  vim.api.nvim_buf_call(buf, function()
    vim.fn.termopen({ 'glow', file })
  end)

  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true
  vim.bo[buf].buftype = "terminal"
  vim.bo[buf].filetype = "glowpreview"

  -- 设置关闭快捷键
  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })

  -- 使用定时器跳转到顶部
  vim.defer_fn(function()
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_win_set_cursor(win, {1, 0})
    end
  end, 100) -- 延迟 100ms（根据你系统情况可调整）
end

-- 针对 Markdown 文件设置
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("n", "ms", ':vsplit | terminal glow %<CR>', { noremap = true, silent = true, buffer = true, desc = "Preview Markdown with Glow" })
        vim.api.nvim_set_keymap('n', 'mp', ':lua GlowMarkdown()<CR>', { noremap = true, silent = true })
    end,
})
