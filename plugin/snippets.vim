lua require('snippy').setup {}


imap <expr> <Tab> snippy#can_expand() ? '<Plug>(snippy-expand)' : '<TAB>'

imap <expr> <C-j> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<C-j>'
imap <expr> <C-k> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<C-k>'
smap <expr> <C-j> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<C-j>'
smap <expr> <C-k> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<C-k>'
