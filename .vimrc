scriptencoding utf-8
set nocompatible
set number
set cursorline " カーソル行強調
set clipboard=unnamed
set includeexpr=''
set autoindent
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=0
set nowrap
set whichwrap=b,s,h,l,<,>,[,]
set ruler
set ambiwidth=double
set foldmethod=marker
set expandtab
set mouse=a
set ttymouse=xterm2
set fileformats=unix,dos,mac     " 改行コードの自動認識
set ignorecase                   " 検索で大文字小文字を区別しない
set smartcase                    " 検索パターンに大文字が含まれる場合だけ大文字小文字を区別する
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set nobackup                     " バックアップ取らない
set noswapfile                   " スワップファイル作らない
set showcmd                      " コマンドをステータス行に表示
set ttyfast                      " 高速ターミナル接続を行う
set lazyredraw
set nrformats-=octal             " 先頭に0がある数字でも10進数とみなす
set wildmenu                     " ファイル名補完
set wildmode=list:longest        " マッチするものをリスト表示しつつ、共通する最長の部分まで補完
set wildignore=.git,.svn,*.jpg,*.jpeg,*.bmp,*.gif,*.png,*.o,*.so,*.out,*.exe,*.dll,*.swp,*.bak,*.old,*.tmp,*.DS_Store
set encoding=utf-8
set fileencoding=utf-8
set incsearch
set hlsearch
set splitbelow
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,
set visualbell
set noerrorbells
set display=lastline " 長い行を表示
set showmatch " 対応する括弧に一瞬カーソルを飛ばす
set matchtime=1 " カーソルを飛ばす時間(0.1秒)
set splitright
set laststatus=2 " ステータスラインを表示
setlocal formatoptions-=ro " コメント記号を自動挿入しない

syntax enable
set background=dark
colorscheme hybrid 

au FileType c setl tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab textwidth=80 colorcolumn=80
au FileType python setl shiftwidth=4 softtabstop=4 textwidth=80 colorcolumn=80
au FileType ruby setl ts=2 shiftwidth=2 softtabstop=2 expandtab iskeyword+=? " ?を含む識別子もひと続きで扱えるように
au BufNewFile,BufRead Rakefile,Capfile,Berksfile,config.ru setf ruby
au BufNewFile,BufRead insns.def setf cruby
au BufNewFile,BufRead *.template setf json
au BufNewFile,BufRead *.yml setf ansible
au BufRead,BufNewFile,BufReadPre *.coffee setf coffee
au BufRead,BufNewFile *.go setf go

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
nmap # gcc
nmap n nzz " 検索語が画面の真ん中に来るようにする

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" 外部で変更のあったファイルを自動的に読み直す http://vim-users.jp/2011/03/hack206/
set autoread
augroup vimrc-checktime
 autocmd!
 autocmd TabEnter * checktime " タブ移動の度にチェック
augroup END

"バイナリ編集
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
  autocmd BufWinEnter,BufNewFile ~/download/ruby/**.[chy] setlocal filetype=cruby
augroup END

" <TAB>で補完
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<TAB>"
  else
    if pumvisible()
      return "\<C-N>"
    else
      return "\<C-N>\<C-P>"
    end
  endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" CRuby関連 {{{
function! s:CRuby_setup()
  setlocal tabstop=8 softtabstop=4 shiftwidth=4 noexpandtab
  syntax keyword cType VALUE ID RUBY_DATA_FUNC BDIGIT BDIGIT_DBL BDIGIT_DBL_SIGNED ruby_glob_func
  syntax keyword cType rb_global_variable
  syntax keyword cType rb_classext_t rb_data_type_t
  syntax keyword cType rb_gvar_getter_t rb_gvar_setter_t rb_gvar_marker_t
  syntax keyword cType rb_encoding rb_transcoding rb_econv_t rb_econv_elem_t rb_econv_result_t
  syntax keyword cType RBasic RObject RClass RFloat RString RArray RRegexp RHash RFile RRational RComplex RData RTypedData RStruct RBignum
  syntax keyword cType st_table st_data
  syntax match   cType display "\<\(RUBY_\)\?T_\(OBJECT\|CLASS\|MODULE\|FLOAT\|STRING\|REGEXP\|ARRAY\|HASH\|STRUCT\|BIGNUM\|FILE\|DATA\|MATCH\|COMPLEX\|RATIONAL\|NIL\|TRUE\|FALSE\|SYMBOL\|FIXNUM\|UNDEF\|NODE\|ICLASS\|ZOMBIE\)\>"
  syntax keyword cStatement ANYARGS NORETURN PRINTF_ARGS
  syntax keyword cStorageClass RUBY_EXTERN
  syntax keyword cOperator IMMEDIATE_P SPECIAL_CONST_P BUILTIN_TYPE SYMBOL_P FIXNUM_P NIL_P RTEST CLASS_OF
  syntax keyword cOperator INT2FIX UINT2NUM LONG2FIX ULONG2NUM LL2NUM ULL2NUM OFFT2NUM SIZET2NUM SSIZET2NUM
  syntax keyword cOperator NUM2LONG NUM2ULONG FIX2INT NUM2INT NUM2UINT FIX2UINT
  syntax keyword cOperator NUM2LL NUM2ULL NUM2OFFT NUM2SIZET NUM2SSIZET NUM2DBL NUM2CHR CHR2FIX
  syntax keyword cOperator NEWOBJ OBJSETUP CLONESETUP DUPSETUP
  syntax keyword cOperator PIDT2NUM NUM2PIDT
  syntax keyword cOperator UIDT2NUM NUM2UIDT
  syntax keyword cOperator GIDT2NUM NUM2GIDT
  syntax keyword cOperator FIX2LONG FIX2ULONG
  syntax keyword cOperator POSFIXABLE NEGFIXABLE
  syntax keyword cOperator ID2SYM SYM2ID
  syntax keyword cOperator RSHIFT BUILTIN_TYPE TYPE
  syntax keyword cOperator RB_GC_GUARD_PTR RB_GC_GUARD
  syntax keyword cOperator Check_Type
  syntax keyword cOperator StringValue StringValuePtr StringValueCPtr
  syntax keyword cOperator SafeStringValue Check_SafeStr
  syntax keyword cOperator ExportStringValue
  syntax keyword cOperator FilePathValue
  syntax keyword cOperator FilePathStringValue
  syntax keyword cOperator ALLOC ALLOC_N REALLOC_N ALLOCA_N MEMZERO MEMCPY MEMMOVE MEMCMP
  syntax keyword cOperator RARRAY RARRAY_LEN RARRAY_PTR RARRAY_LENINT
  syntax keyword cOperator RBIGNUM RBIGNUM_POSITIVE_P RBIGNUM_NEGATIVE_P RBIGNUM_LEN RBIGNUM_DIGITS
  syntax keyword cOperator Data_Wrap_Struct Data_Make_Struct Data_Get_Struct
  syntax keyword cOperator TypedData_Wrap_Struct TypedData_Make_Struct TypedData_Get_Struct

  syntax keyword cConstant Qtrue Qfalse Qnil Qundef
  syntax keyword cConstant IMMEDIATE_MASK FIXNUM_FLAG SYMBOL_FLAG

  " for bignum.c
  syntax keyword cOperator BDIGITS BIGUP BIGDN BIGLO BIGZEROP
  syntax keyword cConstant BITPERDIG BIGRAD DIGSPERLONG DIGSPERLL BDIGMAX
endfunction

function! s:CRuby_ext_setup()
  let dirname = expand("%:h")
  let extconf = dirname . "/extconf.rb"
  if filereadable(extconf)
    call s:CRuby_setup()
  endif
endfunction

augroup CRuby
  autocmd!
  autocmd BufWinEnter,BufNewFile ~/git/ruby/ruby/*.[chy] call s:CRuby_setup()
  autocmd BufWinEnter,BufNewFile *.{c,cc,cpp,h,hh,hpp} call s:CRuby_ext_setup()
augroup END
"}}}

" neosnippet {{{
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/masaki/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/masaki/.vim/bundles')
  call dein#begin('/home/masaki/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/home/masaki/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplcache.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/unite.vim')
  call dein#add('scrooloose/syntastic')
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
	call dein#add('mrkn/vim-cruby')
	call dein#add('szw/vim-tags')
	call dein#add('tpope/vim-fugitive')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

filetype plugin indent on

" }}}

" Checking typo.
" http://d.hatena.ne.jp/tyru/20130419/avoid_tyop
autocmd BufWriteCmd 2,*[,*] call s:write_check_typo(expand('<afile>'))
function! s:write_check_typo(file)
    let prompt = "possible typo: really want to write to '" . a:file . "'?(y/n):"
    let input = input(prompt)
    if input =~? '^y\(es\)\=$'
        execute 'write'.(v:cmdbang ? '!' : '') a:file
    endif
endfunction

let g:syntastic_mode_map = { 'passive_filetypes': ['c'] }

" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_quick_match = 0
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_info = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_force_overwrite_completefunc=1 " vim-railsの補完を上書き
" }}}

let g:vim_json_syntax_conceal = 0 " vim-jsonでconcealをしない

let NERDTreeShowHidden=1
" ブックマークを表示 (1:表示)
let g:NERDTreeShowBookmarks=1
" 引数なしで起動した場合、NERDTreeを開く
autocmd vimenter * if !argc() | NERDTree | endif
" 表示・非表示切り替え
nnoremap <silent><C-t> :NERDTreeToggle<CR>

" vim-tags
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"
