"---------------------------
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
     
    " neobundle自体をneobundleで管理
    NeoBundleFetch 'Shougo/neobundle.vim'

    " メモ用のファイルを作成
    NeoBundle 'Shougo/junkfile.vim'

    " ファイラ
    NeoBundleLazy 'Shougo/vimfiler', {
          \   'autoload' : { 'commands' : [ 'VimFilerBufferDir' ] },
          \   'depends': [ 'Shougo/unite.vim' ],
          \ }
    let s:bundle = neobundle#get("vimfiler")
    function! s:bundle.hooks.on_source(bundle)
      runtime! userautoload/plugins/vimfiler.vim
      echo 'vimfiler.vim started.'
    endfunction
    unlet s:bundle

    " 入力を便利に
    NeoBundleLazy 'kana/vim-smartinput', {
          \   'autoload' : { 'insert' : 1 }
          \ }

    " shell
    NeoBundleLazy 'Shougo/vimshell.vim', {
          \ 'depends' : 'Shougo/vimproc',
          \ 'autoload' : {
          \   'commands' : [{ 'name' : 'VimShell',
          \                   'complete' : 'customlist,vimshell#complete'},
          \                 'VimShellExecute', 'VimShellInteractive',
          \                 'VimShellTerminal', 'VimShellPop'],
          \   'mappings' : ['<Plug>(vimshell_']
          \ }}

    " Unite
    NeoBundleLazy 'Shougo/unite.vim', {
          \   'autoload' : { 'commands' : [ 'Unite' ] },
          \   'mappings' : ['<Plug>(unite']
          \ }
    let s:bundle = neobundle#get("unite.vim")
    function! s:bundle.hooks.on_source(bundle)
      runtime! userautoload/plugins/unite.vim
      " 勝手に起動する？
      " echo 'unite started'
    endfunction
    unlet s:bundle

    " Unite の最近使ったファイル検索用プラグイン
    NeoBundle 'Shougo/neomru.vim'

    " Quick run 
    NeoBundle 'Thinca/vim-quickrun'

    " HTML 編集を効率化
    NeoBundle 'mattn/emmet-vim' 

    " コメントアウトを便利にする
    NeoBundle 'tomtom/tcomment_vim'

    " +-でZoom
    NeoBundle 'zoom.vim'

    " テキスト整形
    NeoBundle 'junegunn/vim-easy-align'

    " PlantUML用シンタックス
    NeoBundle 'aklt/plantuml-syntax'
    
    " end を自動補完
    NeoBundle 'tpope/vim-endwise'

    " Indent line
    NeoBundle 'Yggdroot/indentLine'

    " Twitter Client
    NeoBundle "basyura/TweetVim"
    NeoBundle "basyura/twibill.vim"
    NeoBundle 'mattn/webapi-vim'

    " = 等の入力を便利に
    NeoBundle "kana/vim-smartchr"

    " Simple note plugin 
    NeoBundle "mrtazz/simplenote.vim"

    " テキストを任意の文字で囲う
    NeoBundle 'tpope/vim-surround'

    " JsDoc
    NeoBundle 'heavenshell/vim-jsdoc', {
          \ 'autoload' : { 'filetypes' : 'javascript'  }
          \}

    " markdown 関連
    NeoBundle 'plasticboy/vim-markdown', {
          \ 'autoload' : { 'filetypes' : 'markdown'  }
          \}
    NeoBundle 'kannokanno/previm', {
          \ 'autoload' : { 'filetypes' : 'markdown'  }
          \}

    " ブラウザを起動
    NeoBundleLazy 'tyru/open-browser.vim', {
          \   'autoload' : {
          \       'functions' : "OpenBrowser",
          \       'commands'  : ["OpenBrowser", "OpenBrowserSearch"],
          \       'mappings'  : "<Plug>(openbrowser-smart-search)"
          \   },
          \}

    " gist 
    NeoBundle 'lambdalisue/vim-gista', {
    \ 'depends': [
    \    'Shougo/unite.vim',
    \    'tyru/open-browser.vim',
    \]}

    "強力な補完機能
    NeoBundleLazy 'Shougo/neocomplete', {
          \ 'insert': 1,
          \ }
    let g:neocomplete#enable_at_startup = 1
    let s:bundle = neobundle#get("neocomplete")
    function! s:bundle.hooks.on_source(bundle)
      runtime! userautoload/plugins/neocomplcache.vim
    endfunction
    unlet s:bundle

    " 処理を非同期化
    NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }

    " snippets
    NeoBundleLazy 'Shougo/neosnippet', {
          \ 'insert': 1,
          \ }
    NeoBundleLazy 'Shougo/neosnippet-snippets', {
          \ 'insert': 1,
          \ }
    let s:bundle = neobundle#get("neosnippet")
    function! s:bundle.hooks.on_source(bundle)
      runtime! userautoload/plugins/neosnippet.vim
      " echo 'neosnippet started'
    endfunction
    unlet s:bundle

    " Windows
    if has('win32') || has('win64')
    end

    call neobundle#end()
    " Required
    filetype plugin indent on
     
    " 未インストールのプラグインをインストールするかどうかを尋ねてくれるようにする設定
    NeoBundleCheck

  endif

  filetype on
  filetype plugin indent on

endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


if has('win32unix') || has('win64unix') || has('unix')

  if isdirectory(expand('~/.vim/bundle/'))
    call NeobundleEnable(expand('~/.vim/'))
    " neobundlelazyでhookする
    " runtime! userautoload/plugins/*.vim
  endif

endif


if has('win32') || has('win64')

  if isdirectory(expand('c:/vim/vimfiles/bundle/'))
    call NeobundleEnable(expand('c:/vim/vimfiles/'))
    " neobundlelazyでhookする
    " runtime! userautoload/plugins/*.vim
  endif

endif


