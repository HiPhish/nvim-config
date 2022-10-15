set laststatus=3
let g:NERDTreeStatusline = -1  |" Disable NERDTree magic

augroup StatusLine
au!
au WinEnter,BufEnter * setl stl=%!v:lua.require('hiphish.statusline').statusline('active')
au WinLeave,BufLeave * setl stl=%!v:lua.require('hiphish.statusline').statusline('inactive')
au WinEnter,BufEnter * call s:set_winbar(v:true)
au WinLeave,BufLeave * call s:set_winbar(v:false)
augroup END

" Wrapper function so we can run extra logic before the actual logic
function! s:set_winbar(active)
	" Floating windows are a special case where we don't want a window bar
	if nvim_win_get_config(0).relative != '' 
		return
	endif
	
	if a:active
		setl wbr=%!v:lua.require('hiphish.statusline').winbar('active')
	else
		setl wbr=%!v:lua.require('hiphish.statusline').winbar('inactive')
	endif
endfunction
