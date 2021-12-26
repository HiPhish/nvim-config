" Disable NetRW, Dirvish will take its place
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

nnoremap <silent> <C-j> <Cmd>execute 'Dirvish' expand('%:h')<CR>
nnoremap gx <CMD>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>
