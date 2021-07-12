execute 'source' expand('~/dotfiles/.vim/.plugin.vim')
filetype plugin indent on " ファイル形式別プラグインとインデントを有効
syntax enable " シンタックスハイライト 有効


"-------------一般-------------
" 文字コードをutf-8に設定
set fenc=utf-8
set encoding=utf-8

set nobackup                   " バックアップファイルを作らない
set noswapfile                 " スワップファイルを作らない
set autoread                   " 編集中のファイルが変更されたら自動で読み直す
set hidden                     " 複数ファイルの編集を可能にする
set backspace=indent,eol,start " バックスペースキーの有効
set clipboard+=unnamed         " クリップボードの共有
set showmatch                  " 対応する括弧をハイライト
set ttimeoutlen=50             " ESCキー押してからのタイムラグ(default=100)
set helplang=ja                " ヘルプを日本語
set updatetime=250             " 反映時間



"-------------見た目-------------
" カラースキーム"
set t_Co=256
" colorscheme iceberg
colorscheme tokyonight
let g:tokyonight_menu_selection_background = 'blue'
let g:tokyonight_disable_italic_comment = 1
set bg=dark

set title          " タイトル表示
" set number         " 行番号表示
set cursorline     " カーソル強調
" set scrolloff=100  " カーソルが常に中央
set laststatus=2   " ステータス行表示
set wildmenu       " コマンドライン補完
set ruler          " 右下にカーソル位置を表示
set showcmd        " 入力中のコマンドをステータスに表示する
set showtabline=2  " タブを表示
set noshowmode     " モード文字を非表示



"-------------検索-------------
set hlsearch   " 検索結果のハイライト
set incsearch  " インクリメンタルサーチ
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字を含む文字列での検索時は区別する
set wrapscan   " 検索時に最後まで行ったら最初に戻る
set gdefault   " 置換時のgオプションをデフォルトで有効

" ECSキー2回押してハイライトの切り替え
nnoremap <silent><ESC><ESC> :<C-u>set nohlsearch!<CR>



"-------------タブ/インデント-------------
set autoindent smartindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" filetypeごとのインデントの設定
augroup fileTypeIndent
  autocmd!
  autocmd FileType go         setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python     setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType rust       setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType ruby       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType vim        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType sh         setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType yaml       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType bash       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  autocmd BufNewFile,BufRead *.html.erb setlocal filetype=html
augroup END



"-------------keybind-------------
" <Leader>をスペースに変更
let mapleader = " "

" 入力モードで素早くjjと入力したときはESC
inoremap jj <Esc>

noremap x "_x

" 補完表示時のEnterで改行しない
" inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"
set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" 画面分割
nnoremap ss :split<CR><C-w>w
nnoremap sv :vsplit<CR><C-w>w
" 画面切り替え
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sc <C-w>c

nnoremap j gj
nnoremap k gk

" 挿入モードでのカーソル移動
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>

" visulaモードでインデント調整後に選択範囲を開放しない
vnoremap > >gv
vnoremap < <gv

" 現在のバッファを削除
nmap <Leader>bd :bd<CR>

" バッファの切替
nnoremap <silent> <S-Tab> :bprev<CR>
nnoremap <silent> <Tab> :bnext<CR>



"-------------その他-------------
" スペルチェック
augroup SpellCheck
  autocmd!
  autocmd FileType gitcommit setlocal spell
augroup END



"-------------plugin setting-------------"

" nerdtree
let NERDTreeShowHidden=1 "nerdtreeでドットファイル表示
let NERDTreeIgnore = ['.git$', '__pycache__', '.pyc', 'venv', 'node_modules']
nnoremap <silent><C-e> :NERDTreeToggle<CR> " nerdtreeの表示/非表示


" airline
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = "raven"
let g:airline_theme = "tokyonight"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''


" fzf
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


" easymotion
nmap <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
nmap <Leader>jk <Plug>(easymotion-sol-bd-jk)


" lsp
nmap <Leader>l :LspDefinition<CR>
let g:lsp_diagnostics_echo_cursor = 1


" rust.vim
let g:rustfmt_autosave = 1


" ale
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ }
let g:ale_fixers = {
  \ 'python': ['isort'],
  \ }
let g:ale_fix_on_save = 1
