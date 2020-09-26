scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set nocompatible
set cursorline " カーソル行強調
set clipboard=unnamed
set cindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set textwidth=0 " 自動改行を無効に
set nowrap " 行を折り返さない
set whichwrap=b,s,h,l,<,>,[,] " 行末・行頭から次の行へ移動可能に
set ruler
set ambiwidth=double
set mouse=a
set ttymouse=xterm2
set fileformats=unix,dos,mac     " 改行コードの自動認識
set smartcase                    " 検索パターンに大文字が含まれる場合だけ大文字小文字を区別する
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set nobackup                     " バックアップ取らない
set noswapfile                   " スワップファイル作らない
set lazyredraw
set nrformats-=octal             " 先頭に0がある数字でも10進数とみなす
set wildmenu                     " ファイル名補完
set wildmode=list:longest        " マッチするものをリスト表示しつつ、共通する最長の部分まで補完
set wildignore=.git,.svn,*.jpg,*.jpeg,*.bmp,*.gif,*.png,*.o,*.so,*.out,*.exe,*.dll,*.swp,*.bak,*.old,*.tmp,*.DS_Store
set incsearch
set splitbelow
set splitright
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,
set visualbell
set noerrorbells
set display=lastline " 長い行を表示
set showmatch " 対応する括弧に一瞬カーソルを飛ばす
set matchtime=1 " カーソルを飛ばす時間(0.1秒)
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax enable

colorscheme tender
let g:airline_theme = 'tender'

au FileType c setl tabstop=8 shiftwidth=4 softtabstop=4 colorcolumn=80
au FileType python setl shiftwidth=4 softtabstop=4 colorcolumn=80
au FileType ruby setl iskeyword+=? " ?を含む識別子もひと続きで扱えるように
au BufNewFile,BufRead Rakefile,Capfile,Berksfile,config.ru setf ruby
au BufNewFile,BufRead insns.def setf c
au BufNewFile,BufRead *.template setf json
au BufNewFile,BufRead *.yml setf ansible

noremap <Tab><Right> :tabnext<CR>
noremap <Tab><Left> :tabprevious<CR>
nnoremap <Home> ^
nnoremap :te :tabedit
nnoremap :to :tabonly
nnoremap :Q :tabonly<Bar>q
nnoremap s :Switch<CR>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 
nnoremap Y y$
nnoremap - :split<CR>
nnoremap <Bar> :vsplit<CR>
nnoremap dd "_dd
nmap n nzz " 検索語が画面の真ん中に来るようにする

" 削除した文字列をレジスタに入れない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" tag list
nnoremap t :TlistOpen<CR>

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" 外部で変更のあったファイルを自動的に読み直す http://vim-users.jp/2011/03/hack206/
set autoread
augroup vimrc-checktime
  autocmd!
  autocmd TabEnter * checktime " タブ移動の度にチェック
augroup END

" バイナリ編集
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre *.a,*.o,*.so*,*.out,*.png,*.jpg,*.jpeg.*.gif let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

augroup cruby
  autocmd!
  autocmd BufWinEnter,BufNewFile ~/download/ruby/**.c setfiletype cruby
augroup END

imap  <expr><TAB>
    \ pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

imap <C-k> <Plug>(neosnippet_expand_or_jump)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.vim/bundles/repos/github.com/Shougo/neosnippet-snippets/neosnippets,~/.vim/snippets'

" Required:
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplcache.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('scrooloose/nerdtree')
  call dein#add('thinca/vim-quickrun')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('tpope/vim-endwise')
  call dein#add('elzr/vim-json')
  call dein#add('tpope/vim-rails')
  call dein#add('AndrewRadev/switch.vim')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('vim-scripts/taglist.vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('chase/vim-ansible-yaml')
  call dein#add('fatih/vim-go')
  call dein#add('tpope/vim-commentary')
  call dein#add('bling/vim-airline')
	call dein#add('jacoborus/tender.vim')
	call dein#add('mrkn/vim-cruby')
	call dein#add('tpope/vim-fugitive')
	call dein#add('szw/vim-tags')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'passive_filetypes': ['c', 'python', 'cpp'] }
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:quickrun_config = {}
let g:quickrun_config['python'] = { 'command': 'python3' }
let g:syntastic_python_flake8_exec = 'python3'

if executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '--std=c++17 --stdlib=libc++'
  let g:quickrun_config['cpp/clang++17'] = {
      \ 'cmdopt': '--std=c++17 --stdlib=libc++',
      \ 'type': 'cpp/clang++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++17'}
endif

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_quick_match = 0
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_info = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_force_overwrite_completefunc=1 " vim-railsの補完を上書き

let g:vim_json_syntax_conceal = 0 " vim-jsonでconcealをしない

let g:vimfiler_as_default_explorer = 1 " :e . で VimFiler が起動するようになる
let g:vimfiler_edit_action = 'tabopen' " Vim:Vimfilerのedit actionをtabopenに変更

let NERDTreeShowHidden=1
" ブックマークを表示 (1:表示)
let g:NERDTreeShowBookmarks=1
" 引数なしで起動した場合、NERDTreeを開く
autocmd vimenter * if !argc() | NERDTree | endif
" 表示・非表示切り替え
nnoremap <silent><C-t> :NERDTreeToggle<CR>
