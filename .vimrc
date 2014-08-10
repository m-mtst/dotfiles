set nocompatible
"set number " 行番号表示
"set clipboard=unnamed,autoselect " 無名レジスタの内容をクリップボードに書き込む
set includeexpr=''
set pastetoggle=<F12>
set autoindent
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set tabstop=2
set shiftwidth=2
set whichwrap=b,s,h,l,<,>,[,]
set ruler
set ambiwidth=double
set foldmethod=marker
set expandtab
set mouse=a
set guioptions+=a
set ttymouse=xterm2
set fileformats=unix,dos,mac     " 改行コードの自動認識
set ignorecase                   " 検索時に大文字小文字を区別しない
set smartcase                    " 検索パターンに大文字が含まれる場合だけ大文字小文字を区別する
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set showcmd                      " コマンドをステータス行に表示
set ttyfast                      " 高速ターミナル接続を行う
set nrformats-=octal             " 先頭に0がある数字でも10進数とみなす
set laststatus=2                 " 常にステータスラインを表示
set statusline=%F\ %y[%{&fileencoding}]%{(&ff=='unix'?'':&ff)}\ %m%r%=%l,%c\ [%B]\ %p%%
set t_Co=256                     " 256色
set wildmenu                     " コマンド補完を強化
set wildignore=.git,.svn
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png
set wildignore+=*.o,*.so,*.out,*.exe,*.dll
set wildignore+=*.swp,*.bak,*.old,*.tmp
set wildignore+=*.DS_Store
set encoding=utf-8

setlocal formatoptions-=ro
au FileType c setl ts=8 sw=4 softtabstop=4 noexpandtab
au FileType ruby setl nowrap tabstop=2 tw=0 sw=2 expandtab
au FileType javascript setl nowrap tabstop=2 tw=0 sw=2 expandtab
au FileType coffee setl sw=2 sts=2 tabstop=2 expandtab
au BufNewFile,BufRead Rakefile setf ruby
au BufNewFile,BufRead Capfile setf ruby
au BufNewFile,BufRead Berksfile setf ruby
au BufNewFile,BufRead config.ru setf ruby
au BufNewFile,BufRead insns.def setf c
au BufNewFile,BufRead *.y setf c
au BufNewFile,BufRead *.template setf json
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
syntax enable
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
noremap <Tab><Right> :tabnext<CR>
noremap <Tab><Left> :tabprevious<CR>
nnoremap <Home> ^
nnoremap :tn :tabnew<CR>
nnoremap :te :tabedit
nnoremap :to :tabonly<CR>
nnoremap s :Switch<CR>
" インクリメント
nnoremap <C-i> <C-a>
" デクリメント
nnoremap <C-d> <C-x>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 
" 検索語が画面の真ん中に来るようにする
nmap n nzz

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

" 挿入モード時、ステータスラインの色を変更 {{{
let g:hi_insert = 'highlight StatusLine ctermfg=white ctermbg=blue cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
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

" 検索結果のハイライトをさりげなく消す {{{
" http://d.hatena.ne.jp/viver/20070612/p1
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" }}}

" Unite.vim
nnoremap <silent> <Leader>f :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'

" neobundle
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

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

" Bracketed Paste Modeを有効にする {{{
" http://ttssh2.sourceforge.jp/manual/ja/usage/tips/vim.html
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
" }}}

" 文字コードの自動認識 {{{
" http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = s:fileencodings_default .','. &fileencodings
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" }}}

" NeoBundle {{{
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
"NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'elzr/vim-json'
NeoBundle 'tpope/vim-rails'
"NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'AndrewRadev/switch.vim'

if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
         \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall" command.'
endif
filetype plugin indent on
" }}}

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

" vim-jsonでconcealをしない
let g:vim_json_syntax_conceal = 0

augroup AlpacaTags
  autocmd!
  if exists(':AlpacaTags')
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
    " 毎回保存と同時更新する場合はコメントを外す
    " autocmd BufWritePost * TagsUpdate
  endif
augroup END
