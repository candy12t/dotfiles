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

" 対応する括弧をハイライト
set showmatch

" 反映時間
set updatetime=250

" ESCキー押してからのタイムラグ(default=100)
set ttimeoutlen=50
" 入力モードで素早くjjと入力したときはESC
inoremap jj <Esc>

" ファイル形式別プラグインとインデントを有効
filetype plugin indent on

inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>


"-------------見た目-------------
" シンタックスハイライト 有効
syntax enable

" カラースキーム"
set t_Co=256

set termguicolors
colorscheme tokyonight
let g:tokyonight_menu_selection_background = 'blue'
let g:tokyonight_disable_italic_comment = 1

" colorscheme iceberg
set bg=dark

" 背景透過
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none
" highlight LineNr ctermbg=none
" highlight Folded ctermbg=none
" highlight EndOfBuffer ctermbg=none

" タイトル表示
set title

" 行番号表示
set number

" 相対行番号表示
set relativenumber

" カーソル強調
set cursorline
" hi clear CursorLine
" hi CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=NONE

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


"-------------画面分割-------------
nnoremap ss :split<CR><C-w>w
nnoremap sv :vsplit<CR><C-w>w

nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sc <C-w>c


"-------------タブ/インデント-------------
" 不可視文字を可視化(tab:>-, 半角スペース:.)
" set list listchars=tab:>>-,trail:-

" 改行時にインデントを引き継いで改行
set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

set tabstop=2

set shiftwidth=2

set softtabstop=2
" filetypeごとのインデントの設定
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType go set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

autocmd BufNewFile,BufRead *.html.erb set filetype=html


let mapleader = " "


" 挿入モードでのカーソル移動
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>


" visulaモードでインデント調整後に選択範囲を開放しない
vnoremap > >gv
vnoremap < <gv


" 現在のバッファを削除
nmap <Leader>bd :bd<CR>


" バッファの切替
nnoremap <silent> <S-Tab> :bprev<CR>
nnoremap <silent> <Tab> :bnext<CR>


" 変更点へ移動
nmap <C-p> <Plug>(GitGutterPrevHunk)
nmap <C-n> <Plug>(GitGutterNextHunk)


" nerdtreeでドットファイル表示
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['.git', '__pycache__', '.pyc', 'venv']

" nerdtreeの表示/非表示
nnoremap <silent><C-e> :NERDTreeToggle<CR>


" airlineの設定
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = "raven"
let g:airline_theme = "tokyonight"
let g:airline_powerline_fonts = 1

nnoremap <Leader>r :<C-u>silent call <SID>find_rip_grep()<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>G :GFiles?<CR>
nnoremap <Leader>f :Files<CR>
function! s:find_rip_grep() abort
		call fzf#vim#grep(
                \   'rg --column --color=always --ignore-file line-number --no-heading --hidden --glob "!.git" .+',
                \   1,
                \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
                \   0,
                \ )
endfunction


nmap <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
nmap <Leader>w <Plug>(easymotion-jumptoanywhere)
nmap <Leader>jk <Plug>(easymotion-sol-bd-jk)
nmap <Leader>s <Plug>(easymotion-s2)


nnoremap <silent> <Leader>t :vert rightbelow term ++close tig status<CR>

nmap <Leader>l :LspDefinition<CR>

nnoremap <Leader>d :Gdiff<CR>

let g:ale_linters = {
	\ 'python': ['flake8'],
	\ }

let g:ale_fixers = {
	\ 'python': ['autopep8', 'black', 'isort'],
	\ }

let g:ale_fix_on_save = 1
