augroup NERDTreeStatusLine
	autocmd!
	autocmd BufEnter <buffer> call s:setStl(s:activeStatus ())
	autocmd WinEnter <buffer> call s:setStl(s:activeStatus ())
	autocmd WinLeave <buffer> call s:setStl(s:passiveStatus())
augroup END

function! s:setStl(stl)
	call nvim_win_set_option(nvim_get_current_win(),'stl',a:stl)
endfunction

function! s:activeStatus()
	return '%#User3# NERDTree %#User4#%#TabLineFill#'
endfunction

function! s:passiveStatus()
	return '%#TabLineFill# NERDTree '
endfunction
