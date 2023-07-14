require('dashboard').setup {
  theme = 'hyper',
  preview = {
    command,
    file_path
  },
  config = {
    week_header = {
      enable,
      concat,
      append
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
