local spec = {
    "Olical/conjure",
    lazy = true,
    dependencies = { "PaterJason/cmp-conjure" },
    ft = { "clojure", "fennel", 'lua', "python" },
}

spec.init = function ()
  -- Set configuration options here
  -- vim.g["conjure#debug"] = true
end

return spec
