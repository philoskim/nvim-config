local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
-- keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Going to windows
keymap("n", "<M-Left>", "<C-W>h", default_opts)
keymap("n", "<M-Right>", "<C-W>l", default_opts)
keymap("n", "<M-Up>", "<C-W>k", default_opts)
keymap("n", "<M-Down>", "<C-W>j", default_opts)

-- keymap("t", "<ScrollWheelUp>", "<Nop>", default_opts)
-- keymap("t", "<ScrollWheelDown>", "<Nop>", default_opts)

-- api doc
keymap("n", "<C-a>",
       "<cmd>lua require('lsp_signature').toggle_float_win()<CR>",
       default_opts)

-- yank and paste <Cword>
keymap("n", "<f2>", "yiW", default_opts)
keymap("i", "<f2>", "<esc>yiW", default_opts)
keymap("i", "<f3>", "<C-R>+", default_opts)
keymap("n", "<f3>", '"+p', default_opts)
keymap("n", "<f4>", "Vip", default_opts)

keymap("n", "<f12>", ":ScreenCapture<CR>", default_opts)

vim.cmd [[
  " ^M 지운 후, textwidth에 맞게 한 줄 reformat한다.
  nnoremap <F5> :s/<C-V><C-M>/\r/g<cr> gqj<cr>
]]
