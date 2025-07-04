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
    autocmd BufWritePost *.clj ConjureEvalBuf
    autocmd BufWritePost *.cljc ConjureEvalBuf
    " autocmd BufEnter *.clj noremap <buffer> <2-RightMouse> IcedEvalOuterTopList
  augroup END

  augroup indent4
    autocmd FileType python lua set_indent4()
    " autocmd FileType javascript lua set_indent4()
  augroup END

  function! ScreenCapture()
    let array = []
    for i in range(1, &lines)
        let row = ''
        for j in range(1, &columns)
            let row .= nr2char(screenchar(i, j))
        endfor
        call add(array, row)
    endfor
    tabnew
    call setline('$', array)
  endfunction
  command! ScreenCapture :call ScreenCapture()
 ]]

