if has('win32') || has('win64')

  set backup 
  set backupdir=%temp%
  set directory=%temp%

  if filereadable(expand('c:/vim/vimrc.local'))
    source c:/vim/vimrc.local
  endif

endif


