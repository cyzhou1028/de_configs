local custom_theme = require'lualine.themes.iceberg_light'

custom_theme.visual.a.bg = '#DFC5FE'
custom_theme.visual.a.fg = '#800080'

custom_theme.normal.b.bg = '#DDEEFF'
custom_theme.normal.b.fg = '#282369'

custom_theme.command = {
    a = {bg = '#6AA39C', fg = '#FFFFFF', gui = 'bold'},
    c = {bg = '#CAD0DE', fg = '#282369', gui = 'bold'}
}

custom_theme.normal.c = {bg = '#CAD0DE', fg = '#282369', gui = 'bold'}
custom_theme.insert.c = {bg = '#CAD0DE', fg = '#9CAED6', gui = 'bold'}


require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = custom_theme, --set to 'auto' for different colorschemes
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
