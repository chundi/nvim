-- local colorscheme = 'tokyonight-moon'
-- local colorscheme = 'synthwave84'
-- local colorscheme = 'gruvbox'
-- local colorscheme = 'github_light'
local colorscheme = 'habamax'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

