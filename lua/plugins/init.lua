-- Note: this is where you can add plugins that don't require any configuration.
-- as soon as you need to add options to a plugin consider making a dedicated file.

local Plugins = {
  {'nvim-lua/plenary.nvim'},
  {'tpope/vim-repeat'},
  {'stevearc/dressing.nvim', opts = {}},
  {'nvim-tree/nvim-web-devicons', lazy = true},

  {'mhinz/vim-startify'},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
  {"numToStr/Comment.nvim"},

  -- colorscheme
  {'martinsione/darkplus.nvim',
   init = function() vim.cmd "colorscheme darkplus" end},
}

return Plugins
