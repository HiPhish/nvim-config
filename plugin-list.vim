"      ____  __            _          __    _      __
"     / __ \/ /_  ______ _(_)___     / /   (_)____/ /_
"    / /_/ / / / / / __ `/ / __ \   / /   / / ___/ __/
"   / ____/ / /_/ / /_/ / / / / /  / /___/ (__  ) /_
"  /_/   /_/\__,_/\__, /_/_/ /_/  /_____/_/____/\__/
"                /____/
"
" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018-2020 HiPhish
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

" ===[ Neovim ]================================================================


" ===[ Tim Pope ]==============================================================
Plug 'tpope/vim-fugitive'      " Git support
Plug 'tpope/vim-eunuch'        " UNIX command wrapper
Plug 'tpope/vim-commentary'    " Commenting, uncommenting
Plug 'tpope/vim-ragtag'        " Complete HTML tabs
Plug 'tpope/vim-characterize'  " Better display of character character codes


" ===[ Auto-Completion ]=======================================================
if has('nvim-0.5.0')
	Plug 'haorenW1025/completion-nvim'
	set completeopt=menuone,noinsert,noselect
	augroup completion_nvim
    	autocmd BufEnter * lua require'completion'.on_attach()
	augroup END
	let g:completion_enable_snippet = 'UltiSnips'
	let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
	let g:completion_matching_ignore_case = 1
	let g:completion_trigger_keyword_length = 1
	let g:completion_auto_change_source = 1
	let g:completion_chain_complete_list = {
		\ 'default': [
			\ {'complete_items': ['snippet', 'lsp', 'path']}
		\ ], 
		\ 'lisp': [
			\ {'complete_items': ['snippet', 'vlime', 'path']}
		\ ]
	\ }

	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
	smap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
	imap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
	smap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

	Plug '~/Developer/vim/completion-nvim-vlime/'

	Plug 'mfussenegger/nvim-jdtls'
else
	Plug 'roxma/nvim-yarp' | Plug 'ncm2/ncm2'
	autocmd BufEnter     * call ncm2#enable_for_buffer()
	autocmd TextChangedI * call ncm2#auto_trigger()
endif

" ---[ NCM2 completion sources ]-----------------------------------------------
if has('nvim-0.5.0')
else
	" General
	Plug 'ncm2/float-preview.nvim'
	let g:float_preview#docked = 0
	Plug 'ncm2/ncm2-path'
	Plug 'ncm2/ncm2-bufword'
	" Snippets
	Plug 'ncm2/ncm2-ultisnips' | let g:UltiSnipsEditSplit = 'context'
	inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
	" Programming language
	Plug 'ncm2/ncm2-cssomni'
	Plug 'ncm2/ncm2-jedi'
	Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
	Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
	Plug 'ncm2/ncm2-pyclang'
	let g:ncm2_pyclang#library_path = '/usr/lib/llvm-7/lib/libclang.so.1'
	let g:ncm2_pyclang#args_file_path = ['.clang_complete']
	Plug '~/Developer/vim/ncm2-vlime/'
endif


" ===[ Language Server Protocol ]==============================================
if !has('nvim-0.5.0')
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'ncm2/ncm2-vim-lsp'
	Plug 'thomasfaingnaert/vim-lsp-snippets'
	Plug 'thomasfaingnaert/vim-lsp-ultisnips'
else
	Plug 'neovim/nvim-lsp'
endif


" ===[ Debug Adapter Protocol ]================================================
let g:vimspector_enable_mappings = 'HUMAN'
Plug 'puremourning/vimspector'


" ===[ Enhance Vim ]===========================================================
Plug 'kana/vim-operator-user'  " has some libraries used by other packages

Plug 'chrisbra/NrrwRgn'                 " Narrowing feature
Plug 'fmoralesc/vim-tutor-mode'         " Interactive Vim tutorials
Plug 'Raimondi/delimitMate'             " Auto-insert matching braces
Plug 'luochen1990/rainbow'              " Differently coloured parentheses
Plug 'bronson/vim-visual-star-search'   " Use * on a selection to search for it
Plug 'SirVer/ultisnips'                 " Snippets
Plug 'honza/vim-snippets'               " Snippets for UltiSnips
Plug 'itchyny/lightline.vim'

" Settings local to a given project
Plug 'MarcWeber/vim-addon-local-vimrc'
let g:local_vimrc = {'names':['.vimrc', 'vimrc', 'rc.vim']}

" FZF, the fuzzy finder
Plug 'junegunn/fzf'
let g:fzf_layout = {'down': '~30%'}
Plug 'junegunn/fzf.vim'
nnoremap <C-P> :FZF<CR>
nnoremap <C-N> :Buffers<CR>

" Window-management mode
Plug 'dstein64/vim-win'
let g:win_resize_height = 1
let g:win_resize_width = 1
let g:win_ext_command_map = {
	\ 'q': 'quit',
	\ 'Q': 'quit!',
	\ 'H': 'wincmd >',
	\ 'J': 'wincmd +',
	\ 'K': 'wincmd -',
	\ 'L': 'wincmd <',
	\ '=': 'wincmd =',
\} 

" Vim script testing framework
Plug 'junegunn/vader.vim'               " Testing framework

" Running tests from inside Vim (use my own fork for better Gradle support)
" Plug 'janko/vim-test'
Plug 'HiPhish/vim-test', {'branch': 'gradle'}
if has('nvim')
	let test#strategy = "neovim"
endif

" Surround text objects
Plug 'rhysd/vim-operator-surround'
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sc <Plug>(operator-surround-replace)

" Colour preview inside the text editor
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}  " Colour preview
let g:Hexokinase_virtualText = '⬤'
let g:Hexokinase_ftAutoload = ['vim', 'css', 'conf', 'zathura']
let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba']

" Colour picker
Plug 'KabbAmine/vCoolor.vim'
let g:vcoolor_disable_mappings = 1
let g:vcoolor_custom_picker = 'kcolorchooser --print'
inoremap <c-x><c-c> <c-o>:VCoolIns ra<cr>

" A generic debugger front end
Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Dependency of vim-vebugger
Plug 'idanarye/vim-vebugger', {'branch': 'develop'}  " Debugging
let g:vebugger_leader='<leader>d'

" My own plugins
Plug '~/Developer/vim/info.vim/'
Plug '~/Developer/vim/info+.vim/'
Plug '~/Developer/vim/repl.nvim/'


" ===[ Windows, navigation and so on ]=========================================
Plug 'airblade/vim-gitgutter'  " Git gutter symbols

" Project drawer
Plug 'scrooloose/nerdtree'
let g:NERDTreeMinimalUI=1  " Remove boilerplate clutter
let g:NERDTreeIgnore=['\v\.pyc$', '\v\~$', '\v\.meta$'] " Ignore compiled files
let g:NERDTreeMouseMode = 2  " Single-click for directories

" File system browser
Plug 'justinmk/vim-dirvish'
nnoremap <silent> <C-j> :execute "Dirvish" expand('%:h')<CR>
" Disable NetRW, Dirvish will take its place
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1


" ===[ Syntax checking ]=======================================================
Plug 'scrooloose/syntastic'  " A syntax checker
Plug 'neomake/neomake'       " Asynchronous syntax checker for Neovim


" ===[ Language-specific plugins ]=============================================

" Awk
Plug '~/Developer/vim/awk-ward.nvim/'

" C
Plug 'Rip-Rip/clang_complete'

" C#
Plug 'OmniSharp/omnisharp-vim'

" Common Lisp
" My quicklisp is installed to a non-standard location
let g:lisp_host_quicklisp_setup = '~/.local/share/quicklisp/setup.lisp'
Plug 'adolenc/cl-neovim'
Plug 'l04m33/vlime', {'rtp': 'vim'}
au BufReadPost,BufNewFile vlime* setlocal nonumber nospell
Plug '~/Developer/vim/quicklisp.nvim/'

" GDScript (Godot)
Plug 'habamax/vim-godot'

" Java
if isdirectory(expand('~/Developer/vim/gradle.nvim/'))
	Plug '~/Developer/vim/gradle.nvim/', {'do': 'gradle wrapper && ./gradlew install'}
else
	Plug 'https://gitlab.com/HiPhish/gradle.nvim', {'do': 'gradle wrapper && ./gradlew install'}
endif
" Use my NCM2 completion fork until it gets implemented and merged upstream
" Plug 'HiPhish/Comrade', {'branch': 'ncm2'}

" JavaScript
Plug 'ternjs/tern_for_vim', {'for': 'javacript', 'do': 'npm install'}

" Jinja
Plug '~/Developer/vim/jinja.vim/'

" Kotlin
Plug 'udalov/kotlin-vim'

" Nim
Plug 'zah/nim.vim'

" Python
Plug 'davidhalter/jedi-vim'

" Racket
Plug '~/Developer/neovim.rkt/', {'rtp': 'nvim'}
Plug 'wlangstroth/vim-racket'

" Scheme
Plug '~/Developer/vim/guile.vim'

" Vala
Plug 'arrufat/vala.vim'


" ===[ Colour schemes ]========================================================
Plug 'arakashic/chromatica.nvim'  " Asynchronous clang-based syntax highlighting
Plug 'icymind/NeoSolarized'
