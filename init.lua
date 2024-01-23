require("utils")
require("plugins").setup()

-- vim-plug
vim.cmd([=[
  call plug#begin()
    Plug 'junegunn/fzf'
    Plug 'junegunn/vim-easy-align'
    Plug 'Yggdroot/hiPairs'

    Plug 'guns/vim-sexp', {'for': 'clojure'}
    Plug 'philoskim/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

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

  let g:hiPairs_enable_matchParen = 1
  let g:hiPairs_hl_matchPair = {'term'    : 'underline,bold',
                \               'cterm'   : 'bold',
                \               'ctermfg' : '0',
                \               'ctermbg' : '180',
                \               'gui'     : 'bold',
                \               'guifg'   : '#f7b008',
                \               'guibg'   : 'Black' }

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
]=])
