if has('win32unix') || has('win64unix') || has('unix')

  set backup
  set backupdir=/tmp
  set directory=/tmp

  if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
  endif

endif


