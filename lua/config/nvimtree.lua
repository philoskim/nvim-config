local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = true,
    view = {
      side = "left",
      width = 30,
    },
    filters = {
      custom = { ".git" },
    },
  }
end

return M
