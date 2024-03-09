local M = {}

function M.setup()
  require("ibl").setup {
    indent = { highlight = highlight, char = "┊" },
  }
end

return M
