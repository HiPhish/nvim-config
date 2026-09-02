" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Make space the leader and local leader
let g:mapleader = ' '
let g:maplocalleader = ' '

" Swap ':' and ';'
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" Quickly exit insert- and command mode by pressing kj in succession (supports
" Latin, Cyrillic and Greek)
noremap! kj <esc>
noremap! кј <esc>
noremap! κξ <esc>

" Shortcut to rapidly toggle 'set list'
nnoremap <silent> <leader>l :set list!<CR>
