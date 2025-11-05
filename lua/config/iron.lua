local spec = {
  "Vigemus/iron.nvim",
  ft = { "python", "lua", "sql" },
}

spec.init = function()
  local iron = require("iron.core")
  local view = require("iron.view")

  iron.setup({
    config = {
      -- 원하는 REPL 정의 추가 (이전 답변에서 사용한 psql 예시 포함)
      repl_definition = {
        python = {
          command = { "python" },
        },
        lua = {
          command = { "lua" },
        },
        sql = {
          command = { "psql", "-h", "localhost", "-U", "philos", "-d", "postgres" },
        },
      },
      repl_open_cmd = view.bottom(10),
      -- 버퍼에서 터미널로의 전송이 성공하면 자동으로 포커스를 REPL로 이동
      autofocus_on_run = false,
    },
    -- 키맵 설정 (선택 사항)
    keymaps = {
      send_motion = "<localleader>sm",
      send_line = "<localleader>sl",
      send_mark = "<localleader>ss",
      send_until_cursor = "<leader>su",
      send_paragraph = "<localleader>sp",
      visual_send = "<localleader>sv",
      send_file = "<localleader>sf",
    },
  })

  -- REPL 세션을 여는 키맵 추가 (선택 사항)
  vim.keymap.set('n', '<leader>r', '<cmd>IronRepl<CR>', { desc = 'Open Iron REPL' })
  vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<CR>', { desc = 'Restart Iron REPL' })
end

return spec

