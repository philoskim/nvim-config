require("utils")
require("plugins").setup()

-- vim-plug
vim.cmd([[
  call plug#begin()

  " Select one of following
  " Plug 'ctrlpvim/ctrlp.vim'
  Plug 'junegunn/fzf'
  " Plug 'liuchengxu/vim-clap'

  Plug 'guns/vim-sexp',    {'for': 'clojure'}
  Plug 'liquidz/vim-iced', {'for': 'clojure'}

  call plug#end()

  " Enable vim-iced's default key mapping
  let g:iced_enable_default_key_mappings = v:true
]])
