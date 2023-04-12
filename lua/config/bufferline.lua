local M = {}

local getbufinfo = vim.fn.getbufinfo

local function sort_by_mru(buf_a, buf_b)
  local bufinfo_a = getbufinfo(buf_a.id)
  local bufinfo_b = getbufinfo(buf_b.id)

  return bufinfo_a[1].lastused < bufinfo_b[1].lastused
end

function M.setup()
  require("bufferline").setup {
    options = {
      numbers = "none",
      themable = true,
      --diagnostics = "nvim_lsp",
      separator_style = "slant" or "padded_slant",
      buffer_close_icon = "",
      close_icon = "",
      show_tab_indicators = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      sort_by = sort_by_mru,
      highlights = {
        buffer_selected = {
          fg = "#000000",
          bg = "#ffffff",
        },
      },
    },
  }
end

return M
