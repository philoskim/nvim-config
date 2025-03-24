local opt = vim.opt


function init_clojure()
  opt.iskeyword:remove("/")
  opt.iskeyword:append("-")
  opt.iskeyword:append("_")
  opt.iskeyword:append("?")
  opt.iskeyword:append("!")
end

function set_indent4()
  opt.tabstop = 4
  opt.shiftwidth = 4
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

  "버퍼가 열릴 때 해당 버퍼의 디렉토리로 이동한다.
  ":terminal 명령을 해당 디렉토리에서 열리도록 하기 위해
  autocmd BufEnter * silent! lcd %:p:h
]]

