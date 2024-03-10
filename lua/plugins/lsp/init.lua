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
}

return plugins

