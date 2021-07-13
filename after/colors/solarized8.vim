" Rainbow colours suitable for Solarized
highlight RainbowRed    guifg=#dc322f ctermfg=Red    guibg=NONE ctermbg=NONE
highlight RainbowOrange guifg=#cb4b16 ctermfg=Brown  guibg=NONE ctermbg=NONE
highlight RainbowYellow guifg=#b58900 ctermfg=Yellow guibg=NONE ctermbg=NONE
highlight RainbowGreen  guifg=#859900 ctermfg=Green  guibg=NONE ctermbg=NONE
highlight RainbowCyan   guifg=#2aa198 ctermfg=Cyan   guibg=NONE ctermbg=NONE
highlight RainbowBlue   guifg=#268bd2 ctermfg=Blue   guibg=NONE ctermbg=NONE
highlight RainbowViolet guifg=#6c71c4 ctermfg=White  guibg=NONE ctermbg=NONE

" My own overrides
highlight ErrorMsg    guifg=#dc322f ctermfg=Red    guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight WarningMsg  guifg=#b58900 ctermfg=Yellow guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight SpellBad    guifg=NONE
highlight SpellCap    guifg=NONE
highlight SpellLocal  guifg=NONE
highlight SpellRare   guifg=NONE

if &background == 'dark'
	highlight TabLineFill guifg=#073642 guibg=#586e75
else
	highlight TabLineSel  guifg=#efe9d6 guibg=#94a1a2 gui=bold
	highlight TabLine     guifg=#839496 guibg=#efe9d6 gui=none
	highlight TabLineFill guifg=#efe9d6 guibg=#94a1a2
endif
