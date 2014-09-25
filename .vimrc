"-----------------------------------------------------
" 基本的な設定
"-----------------------------------------------------
"行頭の余白内でTabを打ち込むと'shiftwidth'の数だけインデントする
set smarttab
" 改行コードの自動認識
set fileformats=unix,dos,mac
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースで削除できるものを指定
set backspace=indent,eol,start
" 8進数を10進数として扱う
set nrformats-=octal
"ペーストを受け付ける
" set paste
" マウスを使える場合はvim内で使用可能にする
if has("mouse")
  set mouse=a
endif
" UTF-8の□や○でカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" set wildmode=longest:full,list
set foldmethod=marker

"-----------------------------------------------------
" filetypeのalias
"-----------------------------------------------------
au BufRead,BufNewFile,BufReadPre *coffee   set filetype=coffee
au BufRead,BufNewFile,BufReadPre *vimperatorrc   set filetype=vim
au BufRead,BufNewFile,BufReadPre *zsh*   set filetype=zsh

"-----------------------------------------------------
" キーバインド変更
"-----------------------------------------------------
" Leader
let mapleader = ","
" TODOを探す
noremap <Leader>t :noautocmd vimgrep /TODO/j **/*.rb **/*.js **/*.erb **/*.haml<CR>:cw<CR>
" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %
" vを二回で行末まで選択
vnoremap v $h

" インサートモード
imap  <C-e> <End>
" imap  <C-a> <Home>
imap  <C-a> <C-o>^
imap  <C-w> <C-o>db
imap  <C-b> <Left>
imap  <C-f> <Right>
imap  <C-n> <Down>
imap  <C-p> <Up>
imap  <C-u> <C-u><C-o>d0
imap  <C-d> <Del>
imap <expr> <C-k> "\<C-g>u".(col('.') == col('$') ? '<C-o>gJ' : '<C-o>D')

" コマンドモード
cmap  <C-b> <Left>
cmap  <C-f> <Right>
cmap  <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" ノーマルモード
map  <C-k> <C-w>p
map  <C-l> <C-w>l
map  <C-h> <C-w>h
map  <C-_> o<ESC>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" quickfixでnextとprev
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap j gj
nnoremap k gk
nnoremap <space><space> :<C-u>edit ~/.vimrc<CR>
nnoremap <space>s :<C-u>source ~/.vimrc<CR>
nnoremap <space>p :<C-u>edit ~/.vimrc_plugins<CR>

" 入力モード中に素早くjjと入力した場合はESCとみなす
" 入力モード中に素早く;;と入力した場合はESCとみなす
inoremap  ;;  <Esc>

"-----------------------------------------------------
" ファイル操作関連
"-----------------------------------------------------
" Exploreでカレントディレクトリを開く
set browsedir=current


"-----------------------------------------------------
" 検索関係
"-----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=1000
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻らない
set nowrapscan
" インクリメンタルサーチを使う
set incsearch
" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"-----------------------------------------------------
" 表示関係
"-----------------------------------------------------
" タイトルをウィンドウ枠に表示する
" set title
" 行番号を表示する
set number
" ルーラーを表示
set ruler
" 現在のカーソル行をハイライト
set cursorline
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時に対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を3にする
"set matchtime=3
" シンタックスハイライトを有効にする
syntax on
" syntax enable
"色設定
colorscheme desert
highlight Comment ctermfg=blue
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コマンドライン補完を拡張モードにする
set wildmenu
" 行末から次の行へ移るようにする
" 行末に移動
" set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
matc ZenkakuSpace /　/

" ステータスラインの表示
" 参考URL
"   http://blog.ruedap.com/entry/20110712/vim_statusline_git_branch_name
set statusline=%<     " 行が長すぎるときに切り詰める位置
set statusline+=%n  " バッファ番号
set statusline+=%m    " %m 修正フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=%F    " バッファ内のファイルのフルパス
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}  " fencとffを表示
set statusline+=\     " 空白スペース
set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
set statusline+=%1l   " 何行目にカーソルがあるか
set statusline+=/
set statusline+=%L    " バッファ内の総行数
set statusline+=,
set statusline+=%c    " 何列目にカーソルがあるか
set statusline+=\   " 空白スペース2個
set statusline+=\|%P\|" ファイル内の何％の位置にあるか

" ステータスラインの色
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=darkcyan

"-----------------------------------------------------
" タブ・インデント
"-----------------------------------------------------
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入するとき、代わりに空白を使う
set expandtab
" インデントをオプションの'shiftwidth'の値の倍数に丸める
set shiftround
" オートインデントを有効にする
set autoindent
" 新しい行を作ったときに高度な自動インデントを行う。 'cindent'
" がオンのときは、'smartindent' をオンにしても効果はない。
set smartindent

"----------------------------------------------------
"" 国際化関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
"set encoding=japan
set termencoding=utf-8
set fileencoding=utf-8

"-----------------------------------------------------
" 文字コードの自動認識
"-----------------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac
set whichwrap=b,s,h,l,<,>,[,]
