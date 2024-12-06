local spec = { "L3MON4D3/LuaSnip" }

spec.init = function()
  local luasnip = require "luasnip"

  luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
  }

  -- Lazy load snippets
  require("luasnip.loaders.from_snipmate").lazy_load()

  local vscode = require("luasnip.loaders.from_vscode")
  vscode.lazy_load()
  vscode.lazy_load { paths = { "./snippets/clojure" } }
  vscode.lazy_load { paths = { "./snippets/javascript" } }
  vscode.lazy_load { paths = { "./snippets/python" } }
  vscode.lazy_load { paths = { "./snippets/adoc" } }

  luasnip.filetype_extend("all", { "_" })
end

return spec
