local spec = {'neovim/nvim-lspconfig'}

local lsp = vim.lsp

local lsp_signature = require "lsp_signature"
lsp_signature.setup {
  bind = true,
  floating_window = false,
  hint_enable = false,
  handler_opts = {
    border = "rounded",
  },
  toggle_key = '<C-a>',
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Highlight symbol under the cursor using nvim lsp
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=254 guibg=#505050 guifg=white
      hi! LspReferenceText cterm=bold ctermbg=254 guibg=#505050 guifg=white
      hi! LspReferenceWrite cterm=bold ctermbg=254 guibg=#505050 guifg=white
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd({'CursorHold'}, {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({'CursorMoved', 'CursorHoldI'}, {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Severity signs in nvim lsp diagnostics
  --local signs = { Error = " ", Warn = " ", Hint = "💡" , Info = " " }
  local signs = { Error = "e ", Warn = "w ", Hint = "h ", Info = "i " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Configuration of virtual and floating text
  vim.diagnostic.config({
    virtual_text = false,
    --severity_sort = true,
    float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = true,
    },
  })
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

spec.init = function()
  vim.lsp.config('pyright', {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
  })

  vim.lsp.config('ts_ls', {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
  })

  vim.lsp.config('clojure_lsp', {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
  })

  vim.lsp.config('ruby_lsp', {
      cmd = { "bundle", "exec", "ruby-lsp" },
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
      -- ruby_lsp는 프로젝트 루트의 .ruby-version이나 Gemfile을 기준으로 작동합니다.
  })

  lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

return spec
