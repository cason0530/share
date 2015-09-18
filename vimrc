"Auther: banlei
"QQ:746286349

set nocompatible
" Enable file type detection.
filetype plugin indent on
syntax on
set   autoindent
set   autoread
set   autowrite
set   background=dark
set   backspace=indent,eol,start
set   nobackup
set   cindent
set   cinoptions=:0
set   cursorline
set   completeopt=longest,menuone
set   noexpandtab
set   fileencodings=utf-8,gb2312,gbk,gb18030
set   fileformat=unix
set   foldenable
set   foldmethod=marker
set   guioptions-=T
set   guioptions-=m
set   guioptions-=r
set   guioptions-=l
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   hlsearch
set   ignorecase
set   incsearch
set   laststatus=2
set   mouse=a
set   number
set   pumheight=10
set   ruler
set   shiftwidth=4
set   showcmd
set   smartindent
set   smartcase
set   tabstop=4
set   termencoding=utf-8
set   textwidth=80
set   whichwrap=h,l
set   wildignore=*.bak,*.o,*.e,*~
set   wildmenu
set   wildmode=list:longest,full
"set   wrap
"
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

" Set mapleader
let mapleader=","
" Space to command mode.
nnoremap <space> :
vnoremap <space> :
" Switching between buffers.
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l
" "cd" to change to open directory.
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>


" taglist.vim
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_Show_One_File=1
"let g:Tlist_WinWidth=25
let g:Tlist_WinWidth=30
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1

" NERDTree.vim
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
" cscope.vim
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif
" OmniCppComplete.vim
let g:OmniCpp_DefaultNamespaces=["std"]
let g:OmniCpp_MayCompleteScope=1
let g:OmniCpp_SelectFirstItem=2
" VimGDB.vim
if has("gdb")
	set asm=0
	let g:vimgdb_debug_file=""
	run macros/gdb_mappings.vim
endif
" LookupFile setting
let g:LookupFile_TagExpr='"./tags.filename"'
let g:LookupFile_MinPatLength=2
let g:LookupFile_PreserveLastPattern=0
let g:LookupFile_PreservePatternHistory=1
let g:LookupFile_AlwaysAcceptFirst=1
let g:LookupFile_AllowNewFiles=0
" add by zs 2012-04-11 winManager
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=30
let g:AutoOpenWinManager=0
"let g:miniBufExplorerMoreThanOne=0
nmap wm :WMToggle<cr>
" Man.vim
source $VIMRUNTIME/ftplugin/man.vim
" snipMate
let g:snips_author="Du Jianfeng"
let g:snips_email="cmdxiaoha@163.com"
let g:snips_copyright="SicMicro, Inc"
" plugin shortcuts
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction
"nmap <leader>sa :cs add cscope.out<cr>
"nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
"nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
"nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
"nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
"nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
"nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
"nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
"nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>
nmap <leader>zz <C-w>o
nmap <leader>gs :GetScripts<cr>

nmap <C-_>a :cs add cscope.out<cr>
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<cr><cr>

set	  tags=./tags;
set	  autochdir
let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1 
let Tlist_File_Fold_Auto_Close=1 
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936
set shortmess=atI
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
vmap <C-c> "+y
nnoremap <F2> :g/^\s*$/d<CR>
nnoremap <C-F2> :vert diffsplit
map <M-F2> :tabnew<CR>
map <F3> :tabnew .<CR>
map <C-F3> \be
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
      exec "!g++ % -o %<"
      exec "! ./%<"
   elseif &filetype == 'cpp'
      exec "!g++ % -o %<"
      exec "! ./%<"
   elseif &filetype == 'java' 
      exec "!javac %" 
      exec "!java %<"
   elseif &filetype == 'sh'
   endif
endfunc
set clipboard+=unnamed
set noeb
set confirm
set softtabstop=4
set showmatch
set scrolloff=3
au BufRead,BufNewFile *  setfiletype txt
