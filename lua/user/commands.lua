local opt = vim.opt

function init_clojure()
  opt.iskeyword:remove("/")

  opt.tabstop = 2
  opt.expandtab = true
  opt.shiftwidth = 2
  opt.autoindent = true
  opt.smartindent = true
end

function init_asciidoc()
  opt.textwidth = 90
  vim.cmd [[
    " ^M 지운 후, textwidth에 맞게 한 줄 reformat한다.
    nnoremap <F2> :s/<C-V><C-M>/\r/g<cr> gqj<cr>
  ]]
end

vim.cmd [[
  function! s:trim_trailing_whitespace() abort
    let l:view = winsaveview()
    keeppatterns %substitute/\m\s\+$//e
    call winrestview(l:view)
  endfunction

  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end

  "augroup clojure
  "  autocmd FileType clojure lua init_clojure()
  "  autocmd BufWritePost *.clj IcedRequire
  "  autocmd BufWritePost *.cljc IcedRequire
  "  " autocmd BufEnter *.clj noremap <buffer> <2-RightMouse> IcedEvalOuterTopList
  "augroup END

  augroup clojure
    autocmd FileType clojure lua init_clojure()
    autocmd BufWritePost *.clj ConjureEvalFile
    autocmd BufWritePost *.cljc ConjureEvalFIle
    " autocmd BufEnter *.clj noremap <buffer> <2-RightMouse> IcedEvalOuterTopList
  augroup END

  augroup asciidoc
    autocmd FileType asciidoc lua init_asciidoc()
  augroup END

  augroup plaintex
    autocmd FileType plaintex lua init_asciidoc()
  augroup END

  augroup trim_spaces
    autocmd!
    autocmd BufWritePre * call <SID>trim_trailing_whitespace()
  augroup END
]]

