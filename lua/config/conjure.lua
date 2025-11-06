local spec = {
    "Olical/conjure",
    lazy = true,
    dependencies = { "PaterJason/cmp-conjure" },
    ft = { "clojure", "fennel", 'lua', "python", "sql" },
}

spec.init = function ()
  -- Set configuration options here
  vim.g["conjure#log#wrap"] = true
  vim.g['conjure#client#sql#stdio#command'] = "psql -U philos postgres"
  vim.g["conjure#mapping#eval_visual"] = "ev"
end

return spec
