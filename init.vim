" __     ___           ____   ____    _____       _ _         _
" \ \   / (_)_ __ ___ |  _ \ / ___|  / /_ _|_ __ (_) |___   _(_)_ __ ___
"  \ \ / /| | '_ ` _ \| |_) | |     / / | || '_ \| | __\ \ / / | '_ ` _ \
"   \ V / | | | | | | |  _ <| |___ / /  | || | | | | |_ \ V /| | | | | | |
"    \_/  |_|_| |_| |_|_| \_\\____/_/  |___|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018 HiPhish
"
"    Permission is hereby granted, free of charge, to any person obtaining a
"    copy of this software and associated documentation files (the
"    "Software"), to deal in the Software without restriction, including
"    without limitation the rights to use, copy, modify, merge, publish,
"    distribute, sublicense, and/or sell copies of the Software, and to permit
"    persons to whom the Software is furnished to do so, subject to the
"    following conditions:
"
"    The above copyright notice and this permission notice shall be included
"    in all copies or substantial portions of the Software.
"
"    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
"    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
"    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
"    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
"    USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}


" UTF-8 everywhere
if !has('nvim')
	set encoding=utf-8
	scriptencoding utf-8
endif


" Download 'vim-plug' if it isn't already installed
if empty(glob(stdpath('config') . '/autoload/plug.vim'))
	" -f, --fail            fail silently
	" -L, --location        follow redirections
	" -o, --output <file>   write to the specified output file
	"     --create-dirs     create intermediate directories
	execute '!curl -fLo '.stdpath('config').'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin(stdpath('data').'/site-packages/')
execute 'source ' . stdpath('config') . '/plugin-list.vim'
call plug#end()


" Vim settings
set listchars=tab:├─,trail:•,eol:¬
set fillchars=msgsep:─
set number              " Line numbers.
set numberwidth=1       " Use minimum width of 1.
set wildmode=list:full  " Kind of completion in command-mode.
set mouse=a             " Enable mouse in all modes.
set noshowmatch         " Don't jump to matching braces.
set showcmd             " Display command in the last line of the screen.
set noshowmode          " Don't display the mode in the last line.
set showtabline=2       " Always show the tab line.
set conceallevel=2      " Conceal and replace
if has('nvim')
	set inccommand=nosplit
endif

" Open splits the way I prefer it
set splitright

" Search settings: Jump to match while typing, ignore case except when upper,
" highlight search results
set incsearch ignorecase smartcase hlsearch

" Indent with tabs, align with spaces
set noexpandtab copyindent preserveindent
set softtabstop=0 shiftwidth=4 tabstop=4

" Spell checking (in comments)
set spell
set spelllang=en

" Use <C-P> as file finder
nnoremap <silent> <C-P> :Denite file_rec<CR>
colorscheme NeoSolarized
