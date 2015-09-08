if has('win32') || has('win64')

  ""Using with Cygwin"
  " VIM faq-33.6
  " https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/windows.rc.vim
  set shellcmdflag=-c
	set shellxquote=\"
	set shell=bash.exe
	set shellpipe=2>&1\|\ tee
	set shellredir=>%s\ 2>&1
	set grepprg=grep

  set backup 
  set backupdir=%temp%
  set directory=%temp%

  if filereadable(expand('c:/vim/vimrc.local'))
    source c:/vim/vimrc.local
  endif

endif


