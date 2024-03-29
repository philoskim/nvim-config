local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Colorscheme
    use {
      'martinsione/darkplus.nvim',
      config = function()
        vim.cmd "colorscheme darkplus"
      end,
    }

    -- Startup screen
    use { "mhinz/vim-startify" }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
       requires = {
         {'nvim-lua/plenary.nvim'}
       },
       config = function()
         require('plugins.telescope').setup()
       end,
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    }

    -- Better Netrw
    use { "tpope/vim-vinegar" }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      config = function()
        require("plugins.neogit").setup()
      end,
    }

    -- Gitblame
    use {
      "f-person/git-blame.nvim",
      config = function()
        require('gitblame').setup {
          enabled = false,
          highlight_group = "Question",
          date_format = '%y/%m/%d %H:/%M'
        }
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("plugins.whichkey").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("plugins.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Better surround
    use { "tpope/vim-surround", event = "InsertEnter" }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "unblevable/quick-scope", event = "CursorMoved", disable = false }
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
      disable = true,
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      after = "nvim-treesitter",
      config = function()
        require("plugins.lualine").setup()
      end,
      requires = { "nvim-web-devicons" },
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("plugins.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
    }

    -- FZF Lua
    use {
      "ibhagwan/fzf-lua",
      event = "BufEnter",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require('fzf-lua').setup {
          winopts = { width = 0.9 },
        }
      end
    }

    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("plugins.nvimtree").setup()
      end,
    }

    -- toggleterm
   use {
     "akinsho/toggleterm.nvim",
     tag = 'v2.*',
     config = function()
       require("plugins.toggleterm").setup()
      end,
   }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("plugins.bufferline").setup()
      end,
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufEnter",
      config = function()
        require("dressing").setup {
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = true,
    }

    -- Completion
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "InsertEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("plugins.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      disable = true,
    }

    use { "hrsh7th/cmp-nvim-lsp" }
    use { "ray-x/lsp_signature.nvim" }
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("plugins.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        -- "hrsh7th/cmp-nvim-lsp-signature-help",
        -- "ray-x/cmp-treesitter",
        -- "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("plugins.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        disable = false,
      },
    }

    use {
      'williamboman/mason.nvim',
      requires = {
        'williamboman/mason-lspplugins.nvim',
        'neovim/nvim-lspconfig',
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require'plugins.lsp'.setup()
      end,
    }

    use {
      'glepnir/lspsaga.nvim',
      branch = 'main',
      config = function()
        require('lspsaga').setup {
          definition = {
            width = 0.8,
            height = 0.8,
          },
          finder = {
            max_height = 0.8,
            left_width = 0.3,
            right_width = 0.9,
          },
        }
      end,
    }

    use {
      'williamboman/mason-lspplugins.nvim',
      config = function()
        require("mason-lspconfig").setup()
      end,
    }

    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
          require("plugins.lsp.null-ls").setup()
      end,
      requires = { "nvim-lua/plenary.nvim" },
    }

    use 'simrat39/rust-tools.nvim'

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M

