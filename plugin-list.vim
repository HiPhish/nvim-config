"      ____  __            _          __    _      __
"     / __ \/ /_  ______ _(_)___     / /   (_)____/ /_
"    / /_/ / / / / / __ `/ / __ \   / /   / / ___/ __/
"   / ____/ / /_/ / /_/ / / / / /  / /___/ (__  ) /_
"  /_/   /_/\__,_/\__, /_/_/ /_/  /_____/_/____/\__/
"                /____/
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


" ===[ Tim Pope ]==============================================================
Plug 'tpope/vim-fugitive'      " Git support
Plug 'tpope/vim-eunuch'        " UNIX command wrapper
Plug 'tpope/vim-commentary'    " Commenting, uncommenting
Plug 'tpope/vim-ragtag'        " Complete HTML tabs
Plug 'tpope/vim-characterize'  " Better display of character character codes


" ===[ Shougo ]================================================================
Plug 'Shougo/denite.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neopairs.vim'  " Automatically close parentheses


" ===[ Auto-Completion ]=======================================================
Plug 'Shougo/deoplete.nvim'          " Auto-completion framework
Plug 'Shougo/neoinclude.vim/'        " Include files
Plug 'tweekmonster/deoplete-clang2'  " C/C++ and Objective-C/C++
Plug 'carlitux/deoplete-ternjs'      " JavaScript
Plug 'zchee/deoplete-jedi'           " Python


" ===[ Kana ]==================================================================
Plug 'kana/vim-operator-user'  " has some libraries used by other packages


" ===[ Enhance Vim ]===========================================================
Plug 'junegunn/vader.vim'               " Testing framework
Plug 'junegunn/vim-slash'               " Clear highlight after a search
Plug 'rhysd/vim-operator-surround'      " Surround text objects
Plug 'MarcWeber/vim-addon-local-vimrc'  " Project-local .vimrc file
Plug 'chrisbra/NrrwRgn'                 " Narrowing feature
Plug 'fmoralesc/vim-tutor-mode'         " Interactive Vim tutorials
Plug 'Raimondi/delimitMate'             " Auto-insert matching braces
Plug 'luochen1990/rainbow'              " Differently coloured parentheses
Plug 'bronson/vim-visual-star-search'   " Use * on a selection to search for it
Plug 'SirVer/ultisnips'                 " Snippets
Plug 'honza/vim-snippets'               " Snippets for UltiSnips
Plug '~/Developer/vim/info.vim/'
Plug '~/Developer/vim/repl.nvim/'


" ===[ Windows, navigation and so on ]=========================================
Plug 'airblade/vim-gitgutter'  " Git gutter symbols
Plug 'scrooloose/nerdtree'     " Project drawer
Plug 'justinmk/vim-dirvish'    " File system browser


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
" Plug 'l04m33/vlime', {'rtp': 'vim'}

" JavaScript
Plug 'ternjs/tern_for_vim', {'for': 'javacript', 'do': 'npm install'}

" Jinja
Plug '~/Developer/vim/jinja.vim/'

" Lua
Plug 'xolox/vim-misc'  " Needed by the below
Plug 'xolox/vim-lua-ftplugin', {'for': 'lua'}

" Python
Plug 'davidhalter/jedi-vim'

" Racket
Plug '~/Developer/neovim.rkt/', {'rtp': 'nvim'}
Plug 'wlangstroth/vim-racket'

" ReStructuredText
Plug 'Rykka/riv.vim'


" ===[ Colour schemes ]========================================================
Plug 'arakashic/chromatica.nvim'  " Asynchronous clang-based syntax highlighting
Plug 'icymind/NeoSolarized'
