" SPDX-FileCopyrightText: © 2021 HiPhish
" SPDX-License-Identifier: 0BSD

" Disable NetRW, Dirvish will take its place
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" NERDTree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\v\.pyc$', '\v\.meta$', '\v^__pycache__$']
let g:NERDTreeMouseMode = 2

" Dirvish
nnoremap <silent> <C-j> <Cmd>execute 'Dirvish' expand('%:h')<CR>
nnoremap gx <CMD>silent execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>
