--- global key bindings
local keymap = vim.keymap.set

-- normal and visual mode
vim.cmd [[
  noremap g0 ^
  noremap g9 $
  noremap g2 %
  nnoremap gd <cmd>Lspsaga goto_definition<cr>zz
  nnoremap go <C-o>zz
]]

-- visual mode
local visual_opts2 = { noremap = true, silent = true }
local tb =  require('telescope.builtin')

keymap('v', '<leader>fb', function()
  local text = getVisualSelection()
  tb.current_buffer_fuzzy_find({ default_text = text })
end, visual_opts2)

keymap('v', '<leader>fg', function()
local text = getVisualSelection()
tb.grep_string({ search = text })
end, visual_opts2)


--- utils
local api = vim.api

local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local function getFileExtension()
  local currBufName = api.nvim_buf_get_name(0)
  return vim.fn.matchstr(currBufName, "\\.\\w\\+$")
end

function insertDbg()
  local extension = getFileExtension()

  if extension == ".clj" or extension == ".cljc" then
    vim.cmd('execute "normal" "idbg\\<Esc>w=="')
  elseif extension == ".cljs" then
    vim.cmd('execute "normal" "iclog\\<Esc>w=="')
  end
end

function insertDbgn()
  local extension = getFileExtension()

  if extension == ".clj" or extension == ".cljc" then
    vim.cmd('execute "normal" "idbgn\\<Esc>w=="')
  elseif extension == ".cljs" then
    vim.cmd('execute "normal" "iclogn\\<Esc>w=="')
  end
end

function insertClog()
  vim.cmd('execute "normal" "iclog\\<Esc>w=="')
end

function insertClogn()
  vim.cmd('execute "normal" "iclogn\\<Esc>w=="')
end

function removeDbg()
  vim.cmd('execute "normal" "\\<Esc>w=="')
end

function printEval()
  vim.cmd [[
    let save_cb = &cb
    let regInfo = getreginfo('x')

    try
      execute "normal" "[[%"
      let evaled = getreg('x')
      execute "normal" "o" . evaled
    finally
        let &cb = save_cb
        call setreg('x', regInfo)
    endtry
  ]]
end

--   range_format = function()
--     local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
--     local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
--     vim.lsp.buf.format({
--       range = {
--         ["start"] = { start_row, 0 },
--         ["end"] = { end_row, 0 },
--       },
--       async = true,
--     })
--   end


--- which-key mappings
local key_mappings = {
    { "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },

    { "<leader>=", group = "Format", nowait = false, remap = false },
    { "<leader>==", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format buffer",
        nowait = false, remap = false },

    { "<leader>Q", "<cmd>qa!<CR>", desc = "Quit all", nowait = false, remap = false },
    { "<leader>S", "<cmd>wa<CR>", desc = "Save all", nowait = false, remap = false },

    { "<leader>b", group = "Buffer", nowait = false, remap = false },
    { "<leader>bD", "<Cmd>%bd|e#|bd#<Cr>", desc = "Delete all buffers", nowait = false, remap = false },
    { "<leader>bb", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers", nowait = false, remap = false },
    { "<leader>bc", "<Cmd>bd!<Cr>", desc = "Close current buffer", nowait = false, remap = false },

    { "<leader>d", group = "Debug", nowait = false, remap = false },
    { "<leader>dc", group = "clog(n)", nowait = false, remap = false },
    { "<leader>dcc", "<plug>(sexp_round_head_wrap_element)<cmd>lua insertClog()<cr><esc>w", desc = "Insert clog", nowait = false, remap = false },
    { "<leader>dcn", "<plug>(sexp_round_head_wrap_element)<cmd>lua insertClogn()<cr><esc>w", desc = "Insert clogn", nowait = false, remap = false },
    { "<leader>dd", "<plug>(sexp_round_head_wrap_element)<cmd>lua insertDbg()<cr><esc>w", desc = "Insert dbg/clog", nowait = false, remap = false },
    { "<leader>dn", "<plug>(sexp_round_head_wrap_element)<cmd>lua insertDbgn()<cr><esc>w", desc = "Insert dbgn/clogn", nowait = false, remap = false },
    { "<leader>dr", "<plug>(sexp_raise_element)<cmd>lua removeDbg()<cr>", desc = "Remove dbg(n)/clog(n)", nowait = false, remap = false },

    -- { "<leader>e", group = "Eval", nowait = false, remap = false },
    -- { "<leader>eR", "<cmd>call iced#repl#execute('eval_at_mark', 'A')<cr>", desc = "Re-eval", nowait = false, remap = false },
    -- { "<leader>eb", "<plug>(iced_require)", desc = "Buffer", nowait = false, remap = false },
    -- { "<leader>ec", "<plug>(iced_stdout_buffer_clear)", desc = "Clear stdout", nowait = false, remap = false },
    -- { "<leader>ee", "<plug>(iced_eval_outer_top_list)", desc = "Outermost", nowait = false, remap = false },
    -- { "<leader>ei", "<plug>(iced_eval)<plug>(sexp_inner_element)", desc = "Inner", nowait = false, remap = false },
    -- { "<leader>em", "mA", desc = "Mark", nowait = false, remap = false },
    -- { "<leader>eo", "<plug>(iced_eval)<plug>(sexp_outer_element)", desc = "Outer", nowait = false, remap = false },
    -- { "<leader>ep", '"x<localleader>ee<cmd>lua printEval()<cr>', desc = "Print eval", nowait = false, remap = false },
    -- { "<leader>eq", "<plug>(iced_interrupt)", desc = "Interrupt", nowait = false, remap = false },
    -- { "<leader>er", "<plug>(iced_stdout_buffer_clear)<cmd>call iced#repl#execute('eval_at_mark', 'A')<cr>", desc = "Clear & Re-eval", nowait = false, remap = false },
    -- { "<leader>et", "<plug>(iced_stdout_buffer_toggle)", desc = "Toggle stdout", nowait = false, remap = false },

    { "<leader>f", group = "Find", nowait = false, remap = false },
    { "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Curr buf grep", nowait = false, remap = false },
    { "<leader>fG", "<cmd>lua require('telescope.builtin').grep_string{search=''}<cr>", desc = "Grep", nowait = false, remap = false },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find{default_text=vim.fn.expand('<cword>')}<cr>", desc = "Curr buf cword", nowait = false, remap = false },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files", nowait = false, remap = false },
    { "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "Grep cword", nowait = false, remap = false },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume", nowait = false, remap = false },

    { "<leader>g", group = "Git", nowait = false, remap = false },
    { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Blame", nowait = false, remap = false },
    { "<leader>gt", "<cmd>lua _lazygit_toggle()<cr>", desc = "lazygit Terminal", nowait = false, remap = false },

    { "<leader>l", group = "Lsp", nowait = false, remap = false },
    { "<leader>la", '<cmd>lua require("lsp_signature").toggle_float_win()<CR>', desc = "Api signature", nowait = false, remap = false },
    { "<leader>lc", "<cmd>Lspsaga incoming_calls<CR>", desc = "Call hierachy", nowait = false, remap = false },
    { "<leader>ld", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition", nowait = false, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format", nowait = false, remap = false },
    { "<leader>lg", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "diaGnostics", nowait = false, remap = false },
    { "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover doc", nowait = false, remap = false },
    { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation", nowait = false, remap = false },
    { "<leader>lo", "<cmd>Lspsaga outline<CR>", desc = "Outline", nowait = false, remap = false },
    { "<leader>lr", "<cmd>Lspsaga rename<CR>", desc = "Rename", nowait = false, remap = false },
    { "<leader>ls", "<cmd>Lspsaga finder<CR>", desc = "Symbol", nowait = false, remap = false },
    { "<leader>lt", "<cmd>Lspsaga open_floaterm<CR>", desc = "Terminal", nowait = false, remap = false },

    { "<leader>q", "<cmd>qa<CR>", desc = "Quit", nowait = false, remap = false },
    { "<leader>s", "<cmd>update!<CR>", desc = "Save", nowait = false, remap = false },

    { "<leader>t", group = "Toggle Window", nowait = false, remap = false },
    { "<leader>tb", "<cmd>lua _bash_toggle()<cr>", desc = "Bash", nowait = false, remap = false },
    { "<leader>tc", "<cmd>lua _clojure_toggle()<cr>", desc = "Clojure", nowait = false, remap = false },
    { "<leader>tl", "<cmd>lua _clojure2_toggle()<cr>", desc = "Clojure", nowait = false, remap = false },
    { "<leader>th", "<cmd>lua _haskell_toggle()<cr>", desc = "Haskell", nowait = false, remap = false },
    { "<leader>tn", "<cmd>lua _node_toggle()<cr>", desc = "Node", nowait = false, remap = false },
    { "<leader>tp", "<cmd>lua _python_toggle()<cr>", desc = "Python", nowait = false, remap = false },
    { "<leader>tr", "<cmd>lua _ruby_toggle()<cr>", desc = "Ruby", nowait = false, remap = false },
    { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree", nowait = false, remap = false },

    { "<leader>w", group = "Window", nowait = false, remap = false },
    { "<leader>wH", "<C-w>H", desc = "window to Left", nowait = false, remap = false },
    { "<leader>wJ", "<C-w>J", desc = "window to Lower", nowait = false, remap = false },
    { "<leader>wK", "<C-w>K", desc = "window to Upper", nowait = false, remap = false },
    { "<leader>wL", "<C-w>L", desc = "window to Right", nowait = false, remap = false },
    { "<leader>wc", "<C-w>c", desc = "Close window", nowait = false, remap = false },
    { "<leader>wh", "<C-w>h", desc = "to Left window", nowait = false, remap = false },
    { "<leader>wj", "<C-w>j", desc = "to Lower window", nowait = false, remap = false },
    { "<leader>wk", "<C-w>k", desc = "to Upper window", nowait = false, remap = false },
    { "<leader>wl", "<C-w>l", desc = "to Right window", nowait = false, remap = false },
    { "<leader>ws", "<cmd>split<cr>", desc = "Split window", nowait = false, remap = false },
    { "<leader>wv", "<cmd>vsplit<cr>", desc = "Vsplit window", nowait = false, remap = false },
}

local spec = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = key_mappings,
}

return spec
