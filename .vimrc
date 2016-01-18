" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"
scriptencoding utf-8

" vi 設定と互換性無しの宣言 (先頭行に記載)
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


"========================================
" basic {{{
"========================================

" テキスト表示・タブ関連
set number
set incsearch
set autoindent
set ic
set shiftwidth=2
set tabstop=2
set expandtab

" 特定の言語はタブ幅を変える
augroup vimrc
  " autocmd! FileType python setlocal shiftwidth=4 tabstop=4
  autocmd! FileType markdown setlocal shiftwidth=4 tabstop=4
augroup END

" 行80文字のラインを引く
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" 開いているファイルのディレクトリに自動的に移動
" set autochdir

" ステータスライン for lightline
set laststatus=2

" .mdファイルをmarkdownに紐付け
au BufNewFile,BufRead *.md :set filetype=markdown

" 特殊文字の可視化
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%

" grep結果をQuickFixに表示
" http://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b
autocmd QuickFixCmdPost *grep* cwindow

" 無名レジスタに入るデータを、*レジスタにも入れる。
:set clipboard+=unnamed

" }}}
"========================================


"========================================
" encoding {{{
"========================================

set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp,iso-2022-jp
set ff=unix
set ffs=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

" }}}
"========================================


"========================================
" for linux {{{
"========================================

if has('win32unix') || has('win64unix') || has('unix')

  set backup
  set backupdir=/tmp
  set directory=/tmp

  set encoding=utf-8

  if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
  endif

endif

" }}}
"========================================


"========================================
" for windows {{{
"========================================

if has('win32') || has('win64')

  ""Using with Cygwin"
  " VIM faq-33.6
  " https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/windows.rc.vim
  "set shellcmdflag=-c
	"set shellxquote=\"
	"set shell=bash.exe
	"set shellpipe=2>&1\|\ tee
	"set shellredir=>%s\ 2>&1
	"set grepprg=grep

  set backup
  set backupdir=%temp%
  set directory=%temp%
  set encoding=utf-8
  let $HOME="%userprofile%\\.vim"

  if filereadable(expand('c:/vim/vimrc.local'))
    source c:/vim/vimrc.local
  endif

endif

" }}}
"========================================


"========================================
" jp input {{{
"========================================

if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" 全角スペースの可視化
" http://inari.hatenablog.com/entry/2014/05/05/231307 (参考)
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" }}}
"========================================


"========================================
" plugins {{{
"========================================

" Neobundleの設定
" http://catcher-in-the-tech.net/1063/ (参考)
function! NeobundleEnable(dir)
  filetype off

  let neobundleDir = expand(a:dir . 'bundle/neobundle.vim')

  if has("vim_starting")
    set nocompatible
    " bundleで管理するディレクトリを指定
    " set runtimepath+= を使うと変数を使用できないので以下の様に設定する
    " http://superuser.com/questions/806595/why-the-runtimepath-in-vim-cannot-be-set-as-a-variable (参考)
    exe 'set rtp+=' . l:neobundleDir
  endif

  if isdirectory(l:neobundleDir)
    " Required
    call neobundle#begin(expand(a:dir . 'bundle'))
    " キャッシュの読み込み
    call neobundle#load_cache()

    " neobundle自体をneobundleで管理
    NeoBundleFetch 'Shougo/neobundle.vim'

    "------------------------------
    " メモ用のファイルを作成 {{{
    "------------------------------

    " memo管理用
    NeoBundleLazy 'glidenote/memolist.vim', {
          \   'autoload' : {
          \     'mappings' : ['<Plug>(memolist']
          \   }
          \ }

    nnoremap    [memolist]   <Nop>
    nmap    <space>m [memolist]

    nnoremap <silent> [memolist]n  :MemoNew<CR>
    nnoremap <silent> [memolist]l  :MemoList<CR>
    nnoremap <silent> [memolist]g  :MemoGrep<CR>

    " }}}
    "------------------------------

    "------------------------------
    " ファイラ {{{
    "------------------------------

    NeoBundleLazy 'Shougo/vimfiler', {
          \ 'depends' : 'Shougo/unite',
          \ 'commands' : [
          \ {'name' : ['VimFiler', 'Edit', 'Write'],
          \  'complete' : 'customlist,vimfiler#complete'},
          \ 'Read', 'Source'],
          \ 'mappings' : '<Plug>(vimfiler)',
          \ 'explorer' : 1,
          \ }
    let g:vimfiler_as_default_explorer=1

    " The prefix key
    nnoremap    [vimfiler]   <Nop>
    nmap    <space>f [vimfiler]

    " vimfiler keymap
    nnoremap <silent> [vimfiler]b :<C-u>VimFilerBufferDir<CR>
    nnoremap <silent> [vimfiler]c :<C-u>VimFilerCurrentDir<CR>
    nnoremap <silent> [vimfiler]e :<C-u>VimFilerExplorer<CR>

    " }}}
    "------------------------------

    "------------------------------
    " 入力を便利に {{{
    "------------------------------

    NeoBundleLazy 'kana/vim-smartinput', {
          \   'autoload' : { 'insert' : 1 }
          \ }

    " }}}
    "------------------------------

    "------------------------------
    " shell {{{
    "------------------------------
    NeoBundleLazy 'Shougo/vimshell.vim', {
          \ 'depends' : 'Shougo/vimproc',
          \ 'autoload' : {
          \   'commands' : [{ 'name' : 'VimShell',
          \                   'complete' : 'customlist,vimshell#complete'},
          \                 'VimShellExecute', 'VimShellInteractive',
          \                 'VimShellTerminal', 'VimShellPop'],
          \   'mappings' : ['<Plug>(vimshell_']
          \ }}

    " }}}
    "------------------------------

    "------------------------------
    " Unite {{{
    "------------------------------

    NeoBundleLazy 'Shougo/unite', {
          \ 'autoload' : {
          \    'commands' : [ 'Unite' ],
          \    'mappings' : ['<Plug>(unite']
          \ },
          \ }

    " 最近使ったファイル検索用プラグイン
    NeoBundle 'Shougo/neomru.vim', {
          \ 'depends' : 'Shougo/unite',
          \ }

    " outline
    NeoBundle 'Shougo/unite-outline', {
          \ 'depends' : 'Shougo/unite',
          \ }

    " The prefix key.
    nnoremap    [unite]   <Nop>
    nmap    <space>u [unite]

    " srart with insert mode
    " let g:unite_enable_start_insert=1

    " unite.vim keymap
    nnoremap [unite]u  :<C-u>Unite -no-split<CR><Space>
    nnoremap <silent> [unite]bu :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]fm :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]dm :<C-u>Unite directory_mru<CR>
    nnoremap <silent> [unite]rg :<C-u>Unite -buffer-name=register register<CR>

    " vinarise
    let g:vinarise_enable_auto_detect = 1

    " }}}
    "------------------------------

    "------------------------------
    " Quick run {{{
    "------------------------------

    NeoBundleLazy 'Thinca/vim-quickrun', {
          \   'autoload' : {
          \     'mappings' : [ '<Plug>(quickrun)' ],
          \   }
          \ }

    " quick run を vimproc で非同期処理するための設定
    let g:quickrun_config = {
          \   "_" : {
          \       "outputter/buffer/split" : ":botright 8sp",
          \       "outputter/error/error" : "quickfix",
          \       "outputter/error/success" : "buffer",
          \       "ourputter" : "error",
          \       "runner" : "vimproc",
          \       "runner/vimproc/updatetime" : 60
          \   },
          \}

    " plantuml
    " let g:quickrun_config = {
    " \   "plantuml" :{
    " \       "type" : "plantuml"
    " \   },
    " \
    " \   "plantuml" : {
    " \       "command" : "plantuml",
    " \       "exec" : "%c %s"
    " \       "ourputter" : "null",
    " \   },
    " }

    "}}}
    "------------------------------

    "------------------------------
    " emmet-vim {{{
    "------------------------------

    NeoBundle 'mattn/emmet-vim'

    " HTML header を日本語に設定
    let g:user_emmet_settings = {
          \ 'variables': {
          \ 'lang' : 'ja'
          \ }
          \}

    "}}}
    "------------------------------

    " コメントアウトを便利にする
    NeoBundle 'tomtom/tcomment_vim'

    "------------------------------
    " Zoom {{{
    "------------------------------

    NeoBundleLazy 'zoom.vim', {
          \   'autoload' : {
          \     'commands' : [ 'ZoomIn', 'ZoomOut' ],
          \   }
          \ }

    " }}}
    "------------------------------

    "------------------------------
    " テキスト整形 {{{
    "------------------------------

    NeoBundleLazy 'junegunn/vim-easy-align', {
          \   'autoload' : {
          \     'commands' : [ 'EasyAlign' ],
          \   }
          \ }

    "}}}
    "------------------------------

    "------------------------------
    " PlantUML用シンタックス {{{
    "------------------------------

    NeoBundleLazy 'aklt/plantuml-syntax', {
          \   'autoload' : {
          \     'filetype' : [ 'plantuml' ],
          \   }
          \ }

    " }}}
    "------------------------------

    "------------------------------
    " endwise {{{
    "------------------------------

    NeoBundleLazy 'tpope/vim-endwise', {
          \ 'insert': 1,
          \ }
    " }}}
    "------------------------------

    " Indent line
    NeoBundle 'Yggdroot/indentLine'

    "------------------------------
    " Twitter Client {{{
    "------------------------------

    NeoBundle "basyura/TweetVim"
    NeoBundle "basyura/twibill.vim"
    NeoBundle 'mattn/webapi-vim'

    " The prefix key.
    nnoremap    [tweetvim]   <Nop>
    nmap    <leader>t [tweetvim]

    nnoremap [tweetvim]t  :<C-u>TweetVimSay<space>
    nnoremap [tweetvim]s  :<C-u>TweetVimCommandSay<CR>
    nnoremap [tweetvim]a  :<C-u>TweetVimSwitchAccount<space>
    nnoremap <silent> [tweetvim]h  :<C-u>TweetVimHomeTimeline<CR>
    nnoremap <silent> [tweetvim]m  :<C-u>TweetVimHomeMentions<CR>

    " For unite
    nnoremap <silent> [unite]ta  :Unite tweetvim/account<CR>

    " }}}
    "------------------------------

    "------------------------------
    " smartchr {{{
    "------------------------------

    NeoBundleLazy "kana/vim-smartchr", {
          \ 'insert': 1,
          \ }

    " }}}
    "------------------------------

    " Simple note plugin
    NeoBundleLazy "mrtazz/simplenote.vim", {
          \   'autoload' : {
          \     'commands' : [ 'Simplenote' ],
          \   }
          \ }

    " テキストを任意の文字で囲う
    NeoBundleLazy 'tpope/vim-surround', {
          \ 'insert': 1,
          \ }

    " JsDoc
    NeoBundleLazy 'heavenshell/vim-jsdoc', {
          \ 'autoload' : { 'filetypes' : 'javascript'  }
          \}

    "------------------------------
    " markdown 関連 {{{
    "------------------------------

    NeoBundleLazy 'gabrielelana/vim-markdown', {
          \ 'autoload' : { 'filetypes' : 'markdown'  }
          \}
    NeoBundleLazy 'kannokanno/previm', {
          \ 'autoload' : { 'filetypes' : 'markdown'  }
          \}

    " 日本語が真っ赤になるのでスペルチェック機能はオフ
    let g:markdown_enable_spell_checking = 0

    " デフォルトマッピングをオフ
    let g:markdown_enable_insert_mode_mappings = 0

    " リアルタイムプレビューを有効化
    let g:previm_enable_realtime = 1

    " ヘッダを表示しない
    let g:previm_show_header = 0

    " }}}
    "------------------------------

    " ブラウザを起動
    NeoBundleLazy 'tyru/open-browser.vim', {
          \   'autoload' : {
          \       'functions' : "OpenBrowser",
          \       'commands'  : ["OpenBrowser", "OpenBrowserSearch"],
          \       'mappings'  : "<Plug>(openbrowser-smart-search)"
          \   },
          \}

    " gist
    NeoBundleLazy 'lambdalisue/vim-gista', {
          \ 'autoload' : {
          \   'commands'  : ['Gista'],
          \ },
          \ 'depends': [
          \   'Shougo/unite.vim',
          \   'tyru/open-browser.vim',
          \]}

    "------------------------------
    " neocomplete {{{
    "------------------------------

    NeoBundleLazy 'Shougo/neocomplete', {
          \ 'insert': 1,
          \ }

    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
          \ 'default' : '',
          \ 'vimshell' : $HOME.'/.vimshell_hist',
          \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

    " }}}
    "------------------------------

    " 処理を非同期化
    NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }

    "------------------------------
    " snippets {{{
    "------------------------------

    NeoBundleLazy 'Shougo/neosnippet', {
          \ 'insert': 1,
          \ }
    NeoBundleLazy 'Shougo/neosnippet-snippets', {
          \ 'insert': 1,
          \ }

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<TAB>" : "\<Plug>(neosnippet_expand_or_jump)"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    " }}}
    "------------------------------

    "------------------------------
    " ステータスラインをおしゃれに {{{
    "------------------------------
    NeoBundle 'itchyny/lightline.vim'
    " vim-gitgutter
    " let g:gitgutter_sign_added = '✚'
    " let g:gitgutter_sign_modified = '➜'
    " let g:gitgutter_sign_removed = '✘'

    " lightline.vim
    let g:lightline = {
          \ 'colorscheme': 'jellybeans',
          \ 'mode_map': {'c': 'NORMAL'},
          \ 'active': {
          \   'left': [
          \     ['mode', 'paste'],
          \     ['fugitive', 'gitgutter', 'filename'],
          \   ],
          \   'right': [
          \     ['lineinfo', 'syntastic'],
          \     ['percent'],
          \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
          \   ]
          \ },
          \ 'component_function': {
          \   'modified': 'MyModified',
          \   'readonly': 'MyReadonly',
          \   'fugitive': 'MyFugitive',
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'syntastic': 'SyntasticStatuslineFlag',
          \   'charcode': 'MyCharCode',
          \   'gitgutter': 'MyGitGutter',
          \ },
          \ 'separator': { 'left': '', 'right': '' },
          \ 'subseparator': { 'left': '|', 'right': '|' }
          \ }

    function! MyModified()
      return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &ro ? 'RO' : ''
    endfunction

    function! MyFilename()
      return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
      try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
          let _ = fugitive#head()
          return strlen(_) ? ' '._ : ''
        endif
      catch
      endtry
      return ''
    endfunction

    function! MyFileformat()
      return winwidth('.') > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
      return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
      return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
      return winwidth('.') > 60 ? lightline#mode() : ''
    endfunction

    function! MyGitGutter()
      if ! exists('*GitGutterGetHunkSummary')
            \ || ! get(g:, 'gitgutter_enabled', 0)
            \ || winwidth('.') <= 90
        return ''
      endif
      let symbols = [
            \ g:gitgutter_sign_added . ' ',
            \ g:gitgutter_sign_modified . ' ',
            \ g:gitgutter_sign_removed . ' '
            \ ]
      let hunks = GitGutterGetHunkSummary()
      let ret = []
      for i in [0, 1, 2]
        if hunks[i] > 0
          call add(ret, symbols[i] . hunks[i])
        endif
      endfor
      return join(ret, ' ')
    endfunction

    " https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
    function! MyCharCode()
      if winwidth('.') <= 70
        return ''
      endif

      " Get the output of :ascii
      redir => ascii
      silent! ascii
      redir END

      if match(ascii, 'NUL') != -1
        return 'NUL'
      endif

      " Zero pad hex values
      let nrformat = '0x%02x'

      let encoding = (&fenc == '' ? &enc : &fenc)

      if encoding == 'utf-8'
        " Zero pad with 4 zeroes in unicode files
        let nrformat = '0x%04x'
      endif

      " Get the character and the numeric value from the return value of :ascii
      " This matches the two first pieces of the return value, e.g.
      " "<F>  70" => char: 'F', nr: '70'
      let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

      " Format the numeric value
      let nr = printf(nrformat, nr)

      return "'". char ."' ". nr
    endfunction
    " }}}
    "------------------------------

    " undo履歴を視覚的に
    NeoBundleLazy 'sjl/gundo.vim', {
          \ 'commands': ['GundoToggle' ],
          \ }

    " カラースキーム
    " NeoBundle 'altercation/vim-colors-solarized'
    " NeoBundle 'sjl/badwolf'
    NeoBundle 'w0ng/vim-hybrid'

    " gitの差分管理
    NeoBundleLazy 'tpope/vim-fugitive', {
          \ 'commands': ['w'],
          \ }
    NeoBundleLazy 'airblade/vim-gitgutter', {
          \ 'commands': ['w'],
          \ }

    "------------------------------
    " white-spaceの管理 {{{
    "------------------------------

    NeoBundle 'bronson/vim-trailing-whitespace'

    if neobundle#tap('vim-trailing-whitespace')
      " uniteでスペースが表示されるので、設定でOFFにします。
      let g:extra_whitespace_ignored_filetypes = ['unite']
      let g:better_whitespace_filetypes_blacklist = ['vimfiler']
    endif

    " }}}
    "------------------------------

    " タスク管理
    NeoBundleLazy 'davidoc/taskpaper.vim', {
          \ 'autoload' : { 'filetypes' : 'taskpaper'  }
          \}

    " junkfile
    NeoBundle 'Shougo/junkfile.vim'
    " unite.vim keymap
    nnoremap [unite]j  :<C-u>Unite junkfile/new<CR>

    " todo
    NeoBundle 'freitass/todo.txt-vim'

    " 日本語ヘルプ
    NeoBundle 'vim-jp/vimdoc-ja'

    " Windowsの場合
    if has('win32') || has('win64')
      "pass
    end

    call neobundle#end()
    " Required
    filetype plugin indent on

    " キャッシュの書込み
    NeoBundleSaveCache

    " 未インストールのプラグインをインストールするかどうかを尋ねてくれるようにする設定
    " NeoBundleCheck

  endif

  filetype on
  filetype plugin indent on

endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


if has('win32unix') || has('win64unix') || has('unix')
  if isdirectory(expand('~/.vim/bundle/'))
    call NeobundleEnable(expand('~/.vim/'))
  endif
endif


if has('win32') || has('win64')
  if isdirectory(expand('c:/vim/vimfiles/bundle/'))
    call NeobundleEnable(expand('c:/vim/vimfiles/'))
  endif
endif

" }}}
"========================================

" /* vim:set foldmethod=marker: */
