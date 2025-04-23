local spec = {
  "stevearc/oil.nvim",
  -- Lazy loading is not recommended
  -- because it is very tricky to make it work correctly in all situations.
  lazy = false,
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

spec.config = function()
  require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    -- skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = false,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == '..' or name == '.git'
      end,
    },
    win_options = {
      wrap = true,
    },
  })
end

spec.keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Browse files from here" },
}

return spec
