"---------------------------
" Neobundleの設定
" http://catcher-in-the-tech.net/1063/ (参考)

function! NeobundleEnable(dir)

  filetype off

  let neobundleDir = expand(a:dir . 'neobundle.vim')

  if has("vim_starting")
    set nocompatible
    " bundleで管理するディレクトリを指定
    " set runtimepath+= を使うと変数を使用できないので以下の様に設定する
    " http://superuser.com/questions/806595/why-the-runtimepath-in-vim-cannot-be-set-as-a-variable (参考)
    exe 'set rtp+=' . l:neobundleDir
  endif

  if isdirectory(l:neobundleDir)
    " Required
    call neobundle#begin(expand(a:dir))
     
    " neobundle自体をneobundleで管理
    NeoBundleFetch 'Shougo/neobundle.vim'

    " メモ用のファイルを作成
    NeoBundle 'Shougo/junkfile.vim'
    " ファイラ
    NeoBundle 'Shougo/fimfiler.vim'
    " shell
    NeoBundle 'Shougo/vimshell.vim'
    " 閉じ括弧を自動的に入力
    NeoBundle 'Townk/vim-autoclose'
    " Unite ファイラ
    NeoBundle 'Shougo/unite.vim'
    " Unite の最近使ったファイル検索用プラグイン
    NeoBundle "Shougo/neomru.vim"
    " Quick run 
    NeoBundle 'Thinca/vim-quickrun'
    " ファイルツリーを表示
    NeoBundle 'scrooloose/nerdtree'
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
    " スニペット
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
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
    NeoBundle 'heavenshell/vim-jsdoc'
    " markdown 関連
    NeoBundle 'plasticboy/vim-markdown'
    NeoBundle 'kannokanno/previm'
    NeoBundle 'tyru/open-browser.vim'
    " gist 
    NeoBundle 'lambdalisue/vim-gista', {
    \ 'depends': [
    \    'Shougo/unite.vim',
    \    'tyru/open-browser.vim',
    \]}
    "強力な補完機能
    " if_luaが有効ならneocompleteを使う
    NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
    " 処理を非同期化
    NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }

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
    call NeobundleEnable(expand('~/.vim/bundle/'))
    runtime! userautoload/plugins/*.vim
  endif

endif



if has('win32') || has('win64')

  if isdirectory(expand('c:/vim/vimfiles/bundle/'))
    call NeobundleEnable(expand('c:/vim/vimfiles/bundle/'))
    runtime! userautoload/plugins/*.vim
  endif

endif


