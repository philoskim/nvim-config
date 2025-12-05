-- Note: this is where you can add plugins that don't require any configuration.
-- as soon as you need to add options to a plugin consider making a dedicated file.

local Plugins = {
  {'nvim-lua/plenary.nvim'},
  {'stevearc/dressing.nvim', opts = {}},
  {'nvim-tree/nvim-web-devicons', lazy = true},
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
   "m4xshen/example.nvim",
   init = function()
     require("example").setup()
   end
  },

  {
    "PaterJason/cmp-conjure",
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, { name = "conjure" })
      return cmp.setup(config)
    end,
  },

  {'mhinz/vim-startify'},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
  {"numToStr/Comment.nvim"},

  {"f-person/git-blame.nvim",
   init = function()
     require('gitblame').setup {
       enabled = false,
       highlight_group = "Question",
       date_format = '%y/%m/%d'
     }
   end,
  },

    -- colorscheme
  {'martinsione/darkplus.nvim',
   init = function() vim.cmd "colorscheme darkplus" end},

}

return Plugins
