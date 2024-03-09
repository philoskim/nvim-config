_G.dump = function(...)
  print(vim.inspect(...))
end

_G.prequire = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local M = {}

function M.pr_table (tbl, indent)
  if not indent then indent = 2 end
  local acc = string.rep(" ", indent) .. "{\n"
  indent = indent + 2

  for k, v in pairs(tbl) do
    acc = acc .. string.rep(" ", indent)
    if (type(k) == "number") then
      acc = acc .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      acc = acc  .. k ..  "= "
    end

    if (type(v) == "number") then
      acc = acc .. v .. ",\n"
    elseif (type(v) == "string") then
      acc = acc .. "\"" .. v .. "\",\n"
    elseif (type(v) == "table") then
      acc = acc .. pr_table(v, indent + 2) .. ",\n"
    else
      acc = acc .. "\"" .. tostring(v) .. "\",\n"
    end
  end

  acc = acc .. string.rep(" ", indent-2) .. "}"
  return acc
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
