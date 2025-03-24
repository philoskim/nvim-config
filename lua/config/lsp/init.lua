local plugins = {
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason-lspconfig.nvim'},

  {'williamboman/mason.nvim',
   dependencies = {
     'neovim/nvim-lspconfig',
     'williamboman/mason-lspconfig.nvim',
   },
   init = function()
     require("mason").setup()
     require("mason-lspconfig").setup()
   end
  },

  { "hrsh7th/cmp-nvim-lsp" },

  { "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts)
    end,
  },

  {'glepnir/lspsaga.nvim',
   opts = {
     definition = {
       width = 0.8,
       height = 0.8,
     },
     finder = {
       max_height = 0.8,
       left_width = 0.3,
       right_width = 0.9,
     },
   },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  }
}

return plugins

