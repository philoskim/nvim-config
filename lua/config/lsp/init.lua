local M = {}

local lsp = vim.lsp

local lsp_signature = require "lsp_signature"
lsp_signature.setup {
  bind = true,
  handler_opts = {
    border = "rounded",
  },
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  if client.server_capabilities.document_highlight then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=235 guibg=#45403d
      hi! LspReferenceText cterm=bold ctermbg=235 guibg=#45403d
      hi! LspReferenceWrite cterm=bold ctermbg=235 guibg=#45403d
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Highlight symbol under the cursor using nvim lsp
  if client.server_capabilities.document_highlight then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=254 guibg=DarkGray guifg=Black
      hi! LspReferenceText cterm=bold ctermbg=254 guibg=DarkGray guifg=Black
      hi! LspReferenceWrite cterm=bold ctermbg=254 guibg=DarkGray guifg=Black
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Severity signs in nvim lsp diagnostics
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Configuration of virtual and floating text
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = true,
    },
  })

  require("aerial").on_attach(client, bufnr)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

function M.setup()
  require('lspconfig')['pyright'].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
  })

  require('lspconfig')['tsserver'].setup{
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
  }

  -- require('lspconfig')['clojure-lsp'].setup{
  --     on_attach = on_attach,
  --     flags = lsp_flags,
  -- }

  lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

return M
