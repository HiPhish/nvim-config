let s:names = ['solarized-dark', 'solarized-light']

augroup custom_colors
	autocmd!
	for s:name in s:names
		execute 'autocmd Colorscheme' s:name 'call s:custom()'
	endfor
augroup END

function! s:custom() abort
	" Custom highlight groups for nvim-ts-rainbow
	hi link rainbowcol1 RainbowRed
	hi link rainbowcol2 RainbowYellow
	hi link rainbowcol3 RainbowBlue
	hi link rainbowcol4 RainbowGreen
	hi link rainbowcol5 RainbowOrange
	hi link rainbowcol6 RainbowCyan
	hi link rainbowcol7 RainbowViolet
	hi MatchWord gui=bold  " Extension from vim-matchup
	let g:matchup_matchparen_offscreen = {}
endfunction

for s:name in s:names
	if g:colors_name == s:name
		execute 'colorscheme' g:colors_name
		break
	endif
endfor
