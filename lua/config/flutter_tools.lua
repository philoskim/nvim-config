local spec = {
  'nvim-flutter/flutter-tools.nvim',
  ft = { 'dart' },
  cmd = {
    'FlutterRun',
    'FlutterDevices',
    'FlutterReload',
    'FlutterRestart',
    'FlutterQuit',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
}

spec.config = function ()
  require('flutter-tools').setup({
    decorations = {
      statusline = {
        app_version = true,
        device = true,
      },
    },
    widget_guides = {
      enabled = true,
    },
    closing_tags = {
      highlight = 'Comment',
      prefix = '//',
      enabled = true,
    },
    dev_log = {
      enabled = true,
      open_cmd = "botright 12split",
      focus_on_open = true,
    },
    lsp = {
      color = {
        enabled = true,
        background = true,
        foreground = false,
        virtual_text = true,
        virtual_text_str = "■",
      },
      settings = {
        showTodos = true,
        completeFunctionCalls = true,
        enableSnippets = true,
      },
    },
  })

  vim.keymap.set('n', '<localleader>fe', ':FlutterEmulators<CR>')
  vim.keymap.set('n', '<localleader>ff', ':FlutterRun<CR>')
  vim.keymap.set('n', '<localleader>fq', ':FlutterQuit<CR>')
  vim.keymap.set('n', '<localleader>fr', ':FlutterReload<CR>')
  vim.keymap.set('n', '<localleader>fR', ':FlutterRestart<CR>')
end

return spec
