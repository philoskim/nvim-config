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


  -- 1. 핵심 엔진: vim-dadbod
  -- 이 플러그인은 DB 연결 및 쿼리 실행의 기본 기능을 제공합니다.
  {
    "tpope/vim-dadbod",
    -- 'lazy' 로드: DB 관련 명령어를 사용할 때만 로드되도록 합니다.
    -- :DB, :DBUI 등 명령어로 플러그인을 로드합니다.
    cmd = { "DB", "DBUI" },
    keys = {
      { "<localleader>q", "<Plug>(DBUI_ExecuteQuery)",
        mode = { "n", "v" }, desc = "Execute current statement/selection" },
    },
  },

  -- 2. 사용자 인터페이스: vim-dadbod-ui
  -- 데이터베이스 구조 탐색, 연결 관리, 쿼리 결과 보기를 위한 UI를 제공합니다.
  {
    "kristijanhusak/vim-dadbod-ui",
    -- vim-dadbod이 설치된 후에만 로드되어야 합니다.
    dependencies = { "tpope/vim-dadbod" },
    -- :DBUIToggle 명령어로 플러그인을 로드합니다.
    cmd = { "DBUIToggle", "DBUI" },
    -- 원하는 설정이 있다면 여기에 config 함수를 추가합니다.
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1 -- Nerd Font 사용 시 아이콘 활성화
      vim.g.db_ui_winwidth = 30
      -- 연결 정보 저장 위치: ~/.local/share/nvim/db_ui_connections
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/db_ui_connections"
      vim.g.dbs =
      {
        { name = 'pg-tf-cleaned', url = 'postgres://philos@localhost:5432/toxfree_cleaned' },
        { name = 'pg-lab', url = 'postgres://philos@localhost:5432/postgres' },
      }
    end,
  },

  -- 3. 자동 완성: vim-dadbod-completion (선택 사항)
  -- nvim-cmp와 함께 사용 시 테이블/컬럼 이름 자동 완성을 제공합니다.
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    -- SQL 파일 타입에서만 로드되도록 합니다.
    ft = { "sql", "mysql", "plsql", "sqlite" },
  },

}

return Plugins
