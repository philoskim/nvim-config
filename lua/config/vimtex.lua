local spec = {
    "lervag/vimtex",
    lazy = false,
}

spec.init = function ()
  -- VimTeX가 viewer를 설정하도록 함
  vim.g.vimtex_view_method = "skim"

  -- 컴파일러
  vim.g.vimtex_compiler_method = "latexmk"

  vim.g.vimtex_compiler_latexmk = {
    continuous = 1,
    executable = "latexmk",
    options = {
      "-verbose",
      "-file-line-error",
      "-synctex=1",
      "-interaction=nonstopmode",
      "-lualatex",
    },
  }

  -- quickfix 자동 열기 안 함
  vim.g.vimtex_quickfix_mode = 0

  -- TOC 설정
  vim.g.vimtex_toc_config = {
    show_help = 0,
    split_width = 30,
  }

  -- conceal 비활성화
  vim.g.vimtex_syntax_conceal_disable = 1
end

return spec
