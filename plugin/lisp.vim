" My quicklisp is installed to a non-standard location
let g:lisp_host_quicklisp_setup = '~/.local/share/quicklisp/setup.lisp'

" Settings for Vlime buffers
autocmd BufReadPost,BufNewFile vlime* setlocal nonumber nospell
