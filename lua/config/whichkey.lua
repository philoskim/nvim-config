local api = vim.api

local M = {}

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

function removeDbg()
  vim.cmd('execute "normal" "\\<Esc>w=="')
end

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
    show_help = false,
    plugins = {
      presets = {
        g = false,
      },
    },
  }

  --- normal mode
  local normal_opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local normal_mappings = {
    ["s"] = { "<cmd>update!<CR>", "Save" },
    ["S"] = { "<cmd>wa<CR>", "Save all" },
    ["q"] = { "<cmd>qa<CR>", "Quit" },
    ["Q"] = { "<cmd>qa!<CR>", "Quit" },
    ["o"] = { "<cmd>LSoutlineToggle<cr>", "Outline" },

    b = {
      name = "Buffer",
      b = { "<cmd>Telescope buffers sort_mru=true<cr>", "Buffers" },
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    d = {
      name = "Debug",
      d = { "<plug>(sexp_round_head_wrap_element)<cmd>lua insertDbg()<cr><esc>",
            "Insert dbg/clog" },
      n = { "<plug>(sexp_round_head_wrap_element)<cmd>lua insertDbgn()<cr><esc>",
            "Insert dbgn/clogn" },
      r = { "<plug>(sexp_raise_element)<cmd>lua removeDbg()<cr>",
            "Remove dbg(n)/clog(n)" },
    },

    e = {
      name = "Eval",
      e = { "<plug>(iced_eval_outer_top_list)", "Outermost" },
      b = { "<plug>(iced_require)", "Buffer" },
      m = { "mA", "Mark" },
      r = { "<plug>(iced_stdout_buffer_clear)<cmd>call iced#repl#execute('eval_at_mark', 'A')<cr>",
            "Clear & Re-eval" },
      R = { "<cmd>call iced#repl#execute('eval_at_mark', 'A')<cr>", "Re-eval" },
      i = { "<plug>(iced_eval)<plug>(sexp_inner_element)", "Inner" },
      o = { "<plug>(iced_eval)<plug>(sexp_outer_element)", "Outer" },
      q = { "<plug>(iced_interrupt)", "Interrupt" },
      t = { "<plug>(iced_stdout_buffer_toggle)", "Toggle stdout" },
      c = { "<plug>(iced_stdout_buffer_clear)", "Clear stdout" },
    },

    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      b = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find{default_text=vim.fn.expand('<cword>')}<cr>",
            "Curr buf cword" },
      B = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Curr buf grep" },
      g = { "<cmd>Telescope grep_string<cr>", "Grep cword" },
      G = { "<cmd>lua require('telescope.builtin').grep_string{search=''}<cr>", "Grep" },
      r = { "<cmd>Telescope resume<cr>", "Resume" },
    },

    l = {
      name = "Lsp",
      c = { '<cmd>Lspsaga code_action<CR>', 'Code action' },
      d = { '<cmd>Lspsaga peek_definition<CR>', 'Definition' },
      D = { '<cmd>Lspsaga show_line_diagnostics<CR>', 'Diagnostics' },
      -- D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration' },
      f = { '<cmd>lua vim.lsp.buf.format()<CR>', 'Format' },
      h = { '<cmd>Lspsaga hover_doc<CR>', 'Hover doc' },
      i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation' },
      r = { '<cmd>Lspsaga rename<CR>', 'Rename' },
      s = { '<cmd>Lspsaga lsp_finder<CR>', 'Symbol' },
      t = { '<cmd>Lspsaga open_floaterm<CR>', 'Terminal' },
    },

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    t = {
      name = "Toggle Window",
      t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
      c = { "<cmd>lua _clojure_toggle()<cr>", "Clojure" },
      b = { "<cmd>lua _bash_toggle()<cr>", "Bash" },
      n = { "<cmd>lua _node_toggle()<cr>", "Node" },
      p = { "<cmd>lua _python_toggle()<cr>", "Python" },
    },

    w = {
      name = "Window",
      h = { "<C-w>h", "to Left window" },
      j = { "<C-w>j", "to Lower window" },
      k = { "<C-w>k", "to Upper window" },
      l = { "<C-w>l", "to Right window" },
      H = { "<C-w>H", "window to Left" },
      J = { "<C-w>J", "window to Lower" },
      K = { "<C-w>K", "window to Upper" },
      L = { "<C-w>L", "window to Right" },
      c = { "<C-w>c", "Close window" },
      s = { "<cmd>split<cr>", "Split window" },
      v = { "<cmd>vsplit", "Vsplit window" },
    },
  }

  local visual_opts = {
    mode = "v", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local visual_mappings = {
    l = {
      name = 'Lsp',
      f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'formatting' },
    },
  }

  whichkey.setup(conf)
  whichkey.register(normal_mappings, normal_opts)
  whichkey.register(visual_mappings, visual_opts)


  --- visual mode
  local keymap = vim.keymap.set
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
end

return M
