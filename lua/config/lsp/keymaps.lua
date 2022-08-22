local M = {}

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  ---- Key mappings
  -- Symbols in nvim-lsp
  buf_keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  -- Definition and Declaration in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_keymap(bufnr, 'n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- Hover information in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- Implementation in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- Signature help in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- Workspace in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --Rename symbols in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- Code actions in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- List all references to the symbol using nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Formatting in nvim lsp
  buf_keymap(bufnr, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- Get information about language servers attached to neovim
  buf_keymap(bufnr, 'n', '<leader>li', '<cmd>LspInfo<CR>', opts)

  -- Highlight symbol under the cursor using nvim lsp
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=235 guibg=LightYellow guifg=Black
      hi! LspReferenceText cterm=bold ctermbg=235 guibg=LightYellow guifg=Black
      hi! LspReferenceWrite cterm=bold ctermbg=235 guibg=LightYellow guifg=Black
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

  -- Key bindings in nvim lsp diagnostics
  keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- Code actions in nvim lsp
  keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', opts)

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
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M
