require('dashboard').setup {
  theme = 'hyper',
  shortcut_type = 'number',
  preview = {
    command,
    file_path
  },
  config = {
    week_header = {
      enable = true
    },
    packages = {
      enable = true
    },
    shortcut = {
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' New File',
        group = 'Label',
        action = 'bd',
        key = 'i',
      },
    }
  }
}
