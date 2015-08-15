scriptencoding utf-8
set nocompatible
"set number " 行番号表示
set clipboard=autoselect
set includeexpr=''
set pastetoggle=<F12>
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
set ignorecase                   " 検索時に大文字小文字を区別しない
set smartcase                    " 検索パターンに大文字が含まれる場合だけ大文字小文字を区別する
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set nobackup                     " バックアップ取らない
set nowritebackup
set noswapfile                   " スワップファイル作らない
set autoread                     " 他で書き換えられたら自動で読み直す
set showcmd                      " コマンドをステータス行に表示
set ttyfast                      " 高速ターミナル接続を行う
set lazyredraw
set nrformats-=octal             " 先頭に0がある数字でも10進数とみなす
set laststatus=2                 " 常にステータスラインを表示
set statusline=%F\ %y[%{&fileencoding}]%{(&ff=='unix'?'':&ff)}\ %m%r%=%l,%c\ [%B]\ %p%%
set t_Co=256                     " 256色
set wildmenu                     " コマンド補完を強化
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

setlocal formatoptions-=ro
au FileType c setl tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab textwidth=80 colorcolumn=80
au FileType python setl textwidth=80 colorcolumn=80
au BufNewFile,BufRead Rakefile setf ruby
au BufNewFile,BufRead Capfile setf ruby
au BufNewFile,BufRead Berksfile setf ruby
au BufNewFile,BufRead config.ru setf ruby
au BufNewFile,BufRead insns.def setf c
au BufNewFile,BufRead *.y setf c
au BufNewFile,BufRead *.template setf json
au BufNewFile,BufRead *.yml setf ansible
au BufRead,BufNewFile,BufReadPre *.coffee setf coffee
au BufRead,BufNewFile *.go setf go
syntax enable
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
noremap <Tab><Right> :tabnext<CR>
noremap <Tab><Left> :tabprevious<CR>
nnoremap <Home> ^
nnoremap :te :tabedit
nnoremap :to :tabonly<CR>
nnoremap :Q :tabonly<Bar>q
nnoremap s :Switch<CR>
nnoremap f :VimFilerSplit -simple -winwidth=35 -toggle -force-quit<CR>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 
nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <Bar> :vsplit<CR>
"nnoremap p "0p
nnoremap dd "_dd
nmap n nzz " 検索語が画面の真ん中に来るようにする
"nmap c yygccp

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" 外部で変更のあったファイルを自動的に読み直す http://vim-users.jp/2011/03/hack206/ {{{
augroup vimrc-checktime
  autocmd!
  autocmd TabEnter * checktime
augroup END
"}}}

"バイナリ編集 {{{
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre *.o,*.so*,*.out,*.png,*.jpg,*.jpeg.*.gif let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"}}}

" <TAB>で補完 {{{
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
"}}}

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
" <TAB>: completion.                                         
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'
" }}}

" neobundle
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
" NeoBundle {{{
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'elzr/vim-json'
NeoBundle 'tpope/vim-rails'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle "vim-scripts/taglist.vim"
NeoBundle "leafgarland/typescript-vim"
NeoBundle "chase/vim-ansible-yaml"
NeoBundle "fatih/vim-go"
NeoBundle "tpope/vim-commentary"
NeoBundle "bling/vim-airline"
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
"NeoBundleLazy 'alpaca-tc/alpaca_tags', {
"\ 'depends': ['Shougo/vimproc'],
"\ 'autoload' : {
"\   'commands' : [
"\     { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
"\     { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
"\     'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
"\ ],
"\ }}

if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
         \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall" command.'
endif
filetype plugin indent on
" }}}

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Checking typo.
" http://d.hatena.ne.jp/tyru/20130419/avoid_tyop （一部修正）
autocmd BufWriteCmd 2,*[,*] call s:write_check_typo(expand('<afile>'))
function! s:write_check_typo(file)
    let prompt = "possible typo: really want to write to '" . a:file . "'?(y/n):"
    let input = input(prompt)
    if input =~? '^y\(es\)\=$'
        execute 'write'.(v:cmdbang ? '!' : '') a:file
    endif
endfunction

let g:syntastic_mode_map = { 'passive_filetypes': ['c'] }

let g:changelog_timeformat = "%a %b %e %T %Y"
"let g:changelog_username = system("git config -z user.name") . " <" . system("git config -z user.email") . ">"
let g:changelog_username = "Masaki Matsushita <glass.saga@gmail.com>"

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
let g:vimfiler_as_default_explorer = 1 " :e . で VimFiler が起動するようになる
let g:vimfiler_edit_action = 'tabopen' " Vim:Vimfilerのedit actionをtabopenに変更

let g:alpaca_tags#config = {
                       \    '_' : '-R --sort=yes',
                       \    'ruby': '--languages=+Ruby',
                       \ }

augroup AlpacaTags
  autocmd!
  if exists(':AlpacaTags')
    autocmd BufWritePost Gemfile AlpacaTagsBundle
    autocmd BufEnter * AlpacaTagsSet
    autocmd BufWritePost * AlpacaTagsUpdate
  endif
augroup END

set tags=tags
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
"let Tlist_Show_One_File = 1 "現在編集中のソースのタグしか表示しない
let Tlist_Exit_OnlyWiindow = 1 "taglist が最後のウインドウなら vim を閉じる
"let Tlist_Enable_Fold_Column = 1 " 折り畳み
let Tlist_WinWidth = 80
map <silent> <leader>tl :TlistToggle<CR>
let Tlist_Use_Right_Window = 1 " 右側にtag listのウインドうを表示する
nnoremap l :TlistToggle<CR>
