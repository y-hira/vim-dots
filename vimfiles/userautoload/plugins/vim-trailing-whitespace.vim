if neobundle#tap('vim-trailing-whitespace')
  " uniteでスペースが表示されるので、設定でOFFにします。
  let g:extra_whitespace_ignored_filetypes = ['unite']
  let g:better_whitespace_filetypes_blacklist = ['vimfiler']
endif
