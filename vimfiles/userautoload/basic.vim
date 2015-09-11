" -----------------
" テキスト表示・タブ関連

set number
set incsearch
set autoindent
set ic
set shiftwidth=2
set tabstop=2
set expandtab

augroup vimrc
  autocmd! FileType python setlocal shiftwidth=4 tabstop=4
  autocmd! FileType markdown setlocal shiftwidth=4 tabstop=4
augroup END

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" ステータスライン for lightline
set laststatus=2

" .mdファイルをmarkdownに紐付け
au BufNewFile,BufRead *.md :set filetype=markdown
