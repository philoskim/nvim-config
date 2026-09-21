local spec = {"nvim-tree/nvim-tree.lua"}

local api = vim.api

function nvimTreeToNormalMode()
  -- NvimTree에 focus가 놓일 때, 항상 Normal mode 상태로 유지한다
  local bufnr = api.nvim_get_current_buf()
  local filetype = api.nvim_buf_get_option(bufnr, "filetype")

  if filetype == 'NvimTree' then
    local mode = api.nvim_get_mode()

    if mode.mode == 'i' then
      vim.cmd('stopinsert')
    end
  end
end

spec.init = function()
  vim.cmd [[
    autocmd WinEnter * lua nvimTreeToNormalMode()
  ]]
end

spec.opts = {
  --disable_netrw = true,
  --hijack_netrw = true,
  --open_on_setup = true,
  view = {
    side = "left",
    width = 30,
  },
  filters = {
    custom = {"^.git$"},
    dotfiles = true,
    git_ignored = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    }
  }
}

return spec
