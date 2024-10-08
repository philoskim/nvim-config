local spec = {'akinsho/toggleterm.nvim'}

spec.opts = {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  -- on_create = function() vim.cmd[[startinsert!]] end,
  -- on_open = function() vim.cmd[[startinsert!]] end,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    width = function()
      return math.floor(vim.o.columns * 0.9)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.9)
    end,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}

spec.config = function()
    function _G.set_terminal_keymaps()
      local opts = {noremap = true}
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    vim.cmd[[autocmd WinEnter term://* if &buftype ==# 'terminal' | startinsert! | endif]]

    local Terminal = require("toggleterm.terminal").Terminal

    local bash = Terminal:new({ cmd='bash', hidden=true, direction='float' })
    function _bash_toggle()
        bash:toggle()
    end

    local node = Terminal:new({ cmd='node', hidden=true, direction='float' })
    function _node_toggle()
        node:toggle()
    end

    local python = Terminal:new({ cmd='python', hidden=true, direction='float', })
    function _python_toggle()
        python:toggle()
    end


    local clojure = Terminal:new({
      cmd = 'lein with-profile +local repl',
      hidden = true,
      direction = 'float',
    })


    function _clojure_toggle()
      clojure:toggle()
    end

    local clojure2 = Terminal:new({
      cmd = 'lein repl',
      hidden = true,
      direction = 'float',
    })

    function _clojure2_toggle()
        clojure2:toggle()
    end

    local ruby = Terminal:new({
      cmd = 'irb',
      hidden = true,
      direction = 'horizontal',
    })

    function _ruby_toggle()
        ruby:toggle()
    end

    local haskell = Terminal:new({
      cmd = 'stack ghci',
      hidden = true,
      direction = 'horizontal',
    })

    function _haskell_toggle()
        haskell:toggle()
    end

    -- 참고: https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
    local lazygit_opts = {
      cmd = 'lazygit',
      hidden = true,
      direction = 'tab',
      on_open = function (term)
        local opts = {noremap = true, silent = true}
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', "<Nop>", opts)
      end,
    }

    local lazygit = Terminal:new(lazygit_opts)
    function _lazygit_toggle()
        lazygit:toggle()
    end
end

return spec
