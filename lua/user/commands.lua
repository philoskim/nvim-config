local opt = vim.opt


function init_clojure()
  opt.iskeyword:remove("/")
end

function set_indent4()
  opt.tabstop = 4
  opt.shiftwidth = 4
end

function remove_ctrl_m()
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

  augroup trim_spaces
    autocmd!
    autocmd BufWritePre * call <SID>trim_trailing_whitespace()
  augroup END

  augroup clojure
    autocmd FileType clojure lua init_clojure()
    autocmd BufWritePost *.clj ConjureEvalFile
    autocmd BufWritePost *.cljc ConjureEvalFIle
    " autocmd BufEnter *.clj noremap <buffer> <2-RightMouse> IcedEvalOuterTopList
  augroup END

  augroup indent4
    autocmd FileType python lua set_indent4()
    " autocmd FileType javascript lua set_indent4()
  augroup END

  augroup remove_ctrl_m
    autocmd FileType asciidoc lua remove_ctrl_m()
    autocmd FileType plaintex lua remove_ctrl_m()
  augroup END
]]

