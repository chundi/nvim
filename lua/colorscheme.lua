local colorscheme = 'tokyonight-moon'
-- local colorscheme = 'synthwave84'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

