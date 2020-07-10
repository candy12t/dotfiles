
" 文字コードをutf-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" 複数ファイルの編集を可能にする
set hidden
" バックスペースキーの有効
set backspace=indent,eol,start
" クリップボードの共有
set clipboard=unnamed


"-------------見た目-------------
" シンタックスハイライト 有効
syntax on
" 行番号表示
set number
" 相対行番号表示
set relativenumber
" カーソル強調
set cursorline
" ビープ音の可視化
set visualbell
" ステータス行表示
set laststatus=2
" コマンドライン補完
set wildmenu
" 右下にカーソル位置を表示
set ruler
" 入力中のコマンドをステータスに表示する
set showcmd


"-------------検索-------------
" 検索結果のハイライト
set hlsearch
" インクリメンタルサーチ
set incsearch
" 大文字と小文字を区別しない
set ignorecase
" 大文字を含む文字列での検索時は区別する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 置換時のgオプションをデフォルトで有効
set gdefault
" ECSキー2回押してハイライトの切り替え
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch!<CR>


"-------------タブ/インデント-------------
" 不可視文字を可視化(tab:>-, 半角スペース:.)
set list listchars=tab:>-,trail:.
" 改行時にインデントを引き継いで改行
set autoindent
" 行頭以外のtab文字の表示幅
set tabstop=4
" 行頭でのtabの表示幅
set shiftwidth=4
" tab文字を半角スペースにする
set expandtab
















