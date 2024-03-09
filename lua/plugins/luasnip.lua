local M = {}

function M.setup()
  local luasnip = require "luasnip"

  luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
  }

  -- Lazy load snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  -- Load custom typescript snippets
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/adoc" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/clojure" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/javascript" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/python" } }

  luasnip.filetype_extend("all", { "_" })
end

return M
