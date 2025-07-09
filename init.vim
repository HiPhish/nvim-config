" __     ___           ____   ____    _____       _ _         _
" \ \   / (_)_ __ ___ |  _ \ / ___|  / /_ _|_ __ (_) |___   _(_)_ __ ___
"  \ \ / /| | '_ ` _ \| |_) | |     / / | || '_ \| | __\ \ / / | '_ ` _ \
"   \ V / | | | | | | |  _ <| |___ / /  | || | | | | |_ \ V /| | | | | | |
"    \_/  |_|_| |_| |_|_| \_\\____/_/  |___|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018-2021 HiPhish
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


" Vim settings
set winborder=rounded
set listchars=tab:├─,space:·,trail:•,eol:,extends:…,precedes:…
set fillchars=msgsep:─,foldopen:┌,foldsep:│
set splitright                  " Open splits the way I prefer it
set formatoptions-=t            " Do not auto-wrap text
set number                      " Line numbers.
set numberwidth=1               " Use minimum width of 1.
set wildmode=list:longest,full  " Kind of completion in command-mode.
set wildignorecase              " Ignore case when completing command-line
set mouse=a                     " Enable mouse in all modes.
set noshowmatch                 " Don't jump to matching braces.
set showcmd                     " Display command in the last line of the screen.
set noshowmode                  " Don't display the mode in the last line.
set showtabline=2               " Always show the tab line.
set conceallevel=2              " Conceal and replace
set shortmess+=c                " Don't show messages from completion menu
set shortmess-=F                " Do show file messages
set termguicolors               " Use GUI colours in the terminal
set completeopt=noinsert,menuone,noselect
if has('nvim')
	set inccommand=nosplit
	set tabline=%!luaeval('require\"hiphish.tabline\"()')
	set pumblend=20
endif


" Search settings: Jump to match while typing, ignore case except when upper,
" highlight search results
set incsearch ignorecase smartcase hlsearch

" Indent with tabs, align with spaces
set noexpandtab copyindent preserveindent
set softtabstop=0 shiftwidth=4 tabstop=4

" Spell checking (in comments)
syntax spell default
set spell spelllang=en

" Use Ack instead of Grep
if executable('ag')
	set grepprg=ag\ --nogroup\ --column\ $*
	set grepformat=%f:%l:%c:%m
elseif executable('ack')
	set grepprg=ack\ --nogroup\ --column\ $*
	set grepformat=%f:%l:%c:%m
endif


" ---[ THEME SETTINGS ]--------------------------------------------------------
set background=dark
colorscheme selenized-dark

" I have a custom Alacritty script
if executable('alacritty-theme') && $TERM == 'alacritty'
	let theme = systemlist(['alacritty-theme', 'get'])[0]
	if len(nvim_get_runtime_file(printf('colors/%s.*', theme),  v:false))
		execute 'colorscheme' theme
	endif
endif

" Alternate cursor shape in insert mode
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
	\,sm:block-blinkwait175-blinkoff150-blinkon175
