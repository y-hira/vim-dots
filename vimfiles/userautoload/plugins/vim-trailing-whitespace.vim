if neobundle#tap('vim-trailing-whitespace')
  " uniteでスペースが表示されるので、設定でOFFにします。
  let g:extra_whitespace_ignored_filetypes = ['unite', 'vimfiler']
endif
