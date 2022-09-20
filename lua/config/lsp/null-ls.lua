local M = {}

-- Key bindings in nvim lsp formatting
function M.setup()
  require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
    },
  })
end

return M
