let s:names = ['solarized-dark', 'solarized-light']

augroup custom_colors
	autocmd!
	for s:name in s:names
		execute 'autocmd Colorscheme' s:name 'call s:custom()'
	endfor
augroup END

function! s:custom() abort
	" Custom highlight groups for nvim-ts-rainbow
	hi link TSRainbowRed    RainbowRed
	hi link TSRainbowYellow RainbowYellow
	hi link TSRainbowBlue   RainbowBlue
	hi link TSRainbowGreen  RainbowGreen
	hi link TSRainbowCyan   RainbowCyan
	hi link TSRainbowOrange RainbowOrange
	hi link TSRainbowViolet RainbowViolet

	hi MatchWord gui=bold  " Extension from vim-matchup
	let g:matchup_matchparen_offscreen = {}
endfunction

for s:name in s:names
	if g:colors_name == s:name
		execute 'colorscheme' g:colors_name
		break
	endif
endfor
