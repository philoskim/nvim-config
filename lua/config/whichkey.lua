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
  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["W"] = { "<cmd>wa<CR>", "Save all" },
    ["q"] = { "<cmd>qa<CR>", "Quit" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["o"] = { "<cmd>AerialToggle<cr>", "Outline" },

    b = {
      name = "Buffer",
      b = { "<cmd>Telescope buffers sort_mru=true<cr>", "Buffers" },
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
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

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)


  --- visual mode
  local keymap = vim.keymap.set
  local visual_opts = { noremap = true, silent = true }
  local tb =  require('telescope.builtin')

  keymap('v', '<leader>fb', function()
	  local text = getVisualSelection()
	  tb.current_buffer_fuzzy_find({ default_text = text })
  end, visual_opts)

  keymap('v', '<leader>fg', function()
    local text = getVisualSelection()
    tb.grep_string({ search = text })
  end, visual_opts)
end

return M
