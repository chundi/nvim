-- 字体
-- vim.o.guifont = "Maple Mono SC NF:h12"
vim.o.guifont = "LXGWWenKaiMono Nerd Font:h24:b:#e-subpixelantialias:#h-slight"

-- 主题
-- vim.g.neovide_theme = "tokyonight"
vim.g.neovide_theme = "github_light"

-- 是否记住窗口大小
-- vim.g.neovide_remember_window_size = true

-- 配置内容与边框间距
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 5
vim.g.neovide_padding_left = 5

-- 配置透明和模糊
local alpha = function()
  -- return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  return string.format("%x", math.floor(255 * vim.g.opacity or 0.8))
end
-- vim.g.neovide_transparency = 0.6
vim.g.neovide_opacity = 0.6
vim.g.neovide_window_blurred = true

vim.g.neovide_floating_blur_amount_x = 5.0
vim.g.neovide_floating_blur_amount_y = 5.0

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

-- 配置光标样式、动画及时延
vim.g.neovide_cursor_vfx_mode = "pixiedust"
-- vim.g.neovide_cursor_vfx_mode = "wireframe"
vim.g.neovide_cursor_vfx_opacity = 400.0
vim.g.neovide_cursor_vfx_particle_lifetime = 2.2
vim.g.neovide_cursor_vfx_particle_speed = 5.0
vim.g.neovide_cursor_vfx_particle_density = 20
vim.g.neovide_cursor_vfx_particle_phase = 0.5
vim.g.neovide_cursor_vfx_particle_curl = 0.2

