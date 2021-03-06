
" Base
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.* set nowritebackup nobackup

set modelines=0
set nocompatible
set backspace=2
set number
set tabstop=4
set autoindent
set softtabstop=4
set shiftwidth=4
set ruler
set laststatus=2
set showcmd
set nobackup
set nowritebackup
filetype off
syntax enable

set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" :Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"Plugin 'junegunn/vim-plug'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
"Plugin 'Valloric/YouCompleteMe'
"MarkDown Plugin
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" All of your Plugins must be added before the following line
call vundle#end()

map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

filetype plugin indent on    " required
" Scheme
" colorscheme monokai

" File encoding
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,latin1
endif

" Quit insert mode
inoremap ff			<Esc>
vnoremap ff			<Esc>

" Quit normal mode
nnoremap <Space>q	:qa<CR>

" Movement
nnoremap H			^
nnoremap L			$
vnoremap H			^
vnoremap L			$

" Save file
nnoremap <Space>sf	:w<CR>
nnoremap <Space>sa	:wa<CR>

" Search
nnoremap <Space>ss	*
nnoremap <Space>sc	:nohlsearch<CR>

" Window
nnoremap <Space>ww	<C-W>w
nnoremap <Space>wd	<C-W>c
nnoremap <Space>wh	<C-W>h
nnoremap <Space>wj	<C-W>j
nnoremap <Space>wk	<C-W>k
nnoremap <Space>wl	<C-W>l
nnoremap <Space>we	<C-W>=
nnoremap <Space>ws	<C-W>s
nnoremap <Space>wv	<C-W>v

" Buffer
nnoremap <Space>bf	:BufExplorer<CR>

" Shifting
vmap <tab>			>gv
vmap <s-tab>		<gv

" Pathogen
" execute pathogen#infect()
" execute pathogen#helptags()

" Nerdtree
map <C-M>			:NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1

" CScope
nmap <C-k>s			:cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>g			:cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>c			:cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>t			:cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>e			:cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>f			:cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-k>i			:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-k>d			:cs find d <C-R>=expand("<cword>")<CR><CR>

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif

" Powerline
set t_Co=256
let g:Powerline_symbols='fancy'

" Ctrlp
let g:ctrlp_map='<C-p>'
let g:ctrlp_cmd='CtrlP'

" Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"
let Tlist_Use_SingleClick=1
let Tlist_WinWidth=40

" Title
function AddTitle()
	call append(0,"/*==============================================")
	call append(1,"#")
	call append(2,"# Filename: ".expand("%:t"))
	call append(3,"# Author: abc")
	call append(4,"# Editor: Vim")
	call append(5,"# Create: ".strftime("%Y-%m-%d %H:%M"))
	call append(6,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
	call append(7,"# Description: ")
	call append(8,"#")
	call append(9,"==============================================*/")
echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

function UpdateTitle()
	normal m'
	execute '/# *Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
	normal ''
	normal mk
	execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
	execute "noh"
	normal 'k
	echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction

function TitleDet()
	let n = 1
	while n < 10
		let line = getline(n)
		if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
			call UpdateTitle()
			return
		endif
		let n = n + 1
	endwhile
	call AddTitle()
endfunction

nmap <F8>			:call TitleDet()<CR>

" comment
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
let g:NERDAltDelims_python = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } , 'python': {'left': '#','right': ''}}

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

