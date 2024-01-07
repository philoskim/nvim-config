require("utils")
require("plugins").setup()

-- vim-plug
vim.cmd([=[
  call plug#begin()

  " vim-iced
  " Select one of following
  " Plug 'ctrlpvim/ctrlp.vim'
  Plug 'junegunn/fzf'
  " Plug 'liuchengxu/vim-clap'

  Plug 'junegunn/vim-easy-align'
  Plug 'guns/vim-sexp',    {'for': 'clojure'}
  Plug 'liquidz/vim-iced', {'for': 'clojure'}
  Plug 'liquidz/vim-iced-multi-session', {'for': 'clojure'}

  " Dart/Flutter
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'thosakwe/vim-flutter'
  Plug 'natebosch/vim-lsc'
  Plug 'natebosch/vim-lsc-dart'

  call plug#end()

  " Enable vim-iced's default key mapping
  let g:iced_enable_default_key_mappings = v:true
  let g:iced_default_key_mapping_leader = '<LocalLeader>'
  let g:sexp_enable_insert_mode_mappings = 0
  let g:sexp_mappings = {'sexp_indent': '', 'sexp_indent_top': ''}
  let g:iced_multi_session#does_switch_session = v:true

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
]=])
