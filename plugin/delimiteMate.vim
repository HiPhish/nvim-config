" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

let g:delimitMate_expand_space         = 1
let g:delimitMate_expand_cr            = 1
let g:delimitMate_expand_inside_quotes = 1


augroup VimScript
	autocmd FileType vim let b:delimitMate_quotes = "'"
augroup END

augroup TeX-Family
	" This one is which you're most likely to use?
	autocmd FileType tex,latex,plaintex let b:delimitMate_quotes = '$ " ''' 
	autocmd FileType tex,latex,plaintex let b:delimitMate_matchpairs = '(:),[:],{:}'
augroup end

augroup Lua
	autocmd FileType lua let b:delimitMate_quotes = '" '''
augroup END

augroup SGML-Family
	autocmd FileType html,xml let b:delimitMate_matchpairs = '(:),[:],{:},<:>'
augroup END

augroup Jinja
	autocmd FileType jinja   let b:delimitMate_quotes = '" '''
	autocmd FileType jinja.* let b:delimitMate_quotes = '" '''

	autocmd FileType *.jinja
				\ if exists('b:delimitMate_quotes')
				\ | let b:delimitMate_quotes.='" '' # %'
				\ | else
				\ | let b:delimitMate_quotes='" '' # %'
				\ | endif
augroup END

augroup Django
	autocmd!
	autocmd FileType htmldjango let b:delimitMate_quotes = '" '' # %'
augroup END

augroup Lisp-Family
	autocmd FileType lisp,scheme,racket  let b:delimitMate_quotes = '"'
	autocmd FileType lisp,scheme,racket  let b:delimitMate_expand_cr = 1
	autocmd FileType lisp,scheme,racket  let b:delimitMate_matchpairs = '(:),[:]'
augroup END


augroup Info-Files
	autocmd FileType info let b:delimitMate_matchpairs = &matchpairs.',‘:’'
augroup END
