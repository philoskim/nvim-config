local spec = {
    "Olical/conjure",
    lazy = true,
    dependencies = { "PaterJason/cmp-conjure" },
    ft = { "clojure", "fennel", 'lua', "python" },
}

spec.init = function ()
  -- Set configuration options here
  vim.g["conjure#log#wrap"] = true
end

return spec
