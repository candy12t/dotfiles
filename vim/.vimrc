" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}


"-------------一般-------------
" 文字コードをutf-8に設定
set fenc=utf-8
set encoding=utf-8

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

" 入力モードで素早くjjと入力したときはESC
inoremap jj <Esc>

" ファイル形式別プラグインとインデントを有効
filetype plugin indent on


"-------------見た目-------------
" シンタックスハイライト 有効
syntax enable

" カラースキーム"
colorscheme iceberg
set bg=dark

" タイトル表示
set title

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

" タブを表示
set showtabline=2

" モード文字を非表示
set noshowmode

" カーソルが常に中央
set scrolloff=100


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
" set list listchars=tab:>>-,trail:-

" 改行時にインデントを引き継いで改行
set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

" filetypeごとのインデントの設定
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType go set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

autocmd BufNewFile,BufRead *.html.erb set filetype=html


" 挿入モードでのカーソル移動
inoremap <silent> <C-f> <Right>
inoremap <silent> <C-b> <Left>


" nerdtreeでドットファイル表示
let NERDTreeShowHidden=1

" nerdtreeの表示/非表示
nnoremap <silent><C-e> :NERDTreeToggle<CR>


" airlineの設定
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "raven"
let g:airline_powerline_fonts = 1

" airlineのタブ移動
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

