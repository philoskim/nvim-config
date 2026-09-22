local spec = {
  'nvim-lualine/lualine.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'}
}

spec.opts = {
  options = {
    icons_enabled = true,
    theme = "material",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_c = {
      { "filename",
        path = 1 },
    },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filename", path = 1, }
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {},
}

return spec
